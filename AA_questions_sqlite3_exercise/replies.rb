# returns objects constucted from the replies table when queries are submitted. 
class Replies
    attr_accessor :id, :subject_question, :parent_reply_id, :author_id, :body
  
    def self.all
      data = QuestionsDatabase.instance.execute('SELECT * FROM replies')
      data.map { |datum| Replies.new(datum) }
    end
  
    def self.find_by_id(id)
      reply = QuestionsDatabase.instance.execute(<<-SQL, id)
        SELECT *
        FROm replies
        WHERE id = ?
      SQL
      return nil unless reply.length.positive?
  
      Replies.new(reply.first)
    end
  
    def self.find_by_user_id(author_id)
      replies = QuestionsDatabase.instance.execute(<<-SQL, author_id)
        SELECT *
        FROM replies
        WHERE author_id = ?
      SQL
      return nil unless replies.length.positive?
  
      replies.map { |datum| Replies.new(datum) }
    end
  
    def self.find_by_question_id(subject_question)
      replies = QuestionsDatabase.instance.execute(<<-SQL, subject_question)
        SELECT *
        FROM replies
        WHERE subject_question = ?
      SQL
      return nil unless replies.length.positive?
  
      replies.map { |datum| Replies.new(datum) }
    end
  
    def initialize(hash)
      @id = hash["id"]
      @subject_question = hash["subject_question"]
      @parent_reply_id = hash["parent_reply_id"]
      @author_id = hash["author_id"]
      @body = hash["body"]
    end
  
    def insert
      QuestionsDatabase.instance.execute(<<-SQL, subject_question, parent_reply_id, author_id, body)
        INSERT INTO replies (subject_question, parent_reply_id, author_id, body)
        VALUES (?, ?, ?, ?)
      SQL
      self.id = QuestionsDatabase.instance.last_insert_row_id
    end
  
    def author
      author = QuestionsDatabase.instance.execute(<<-SQL, author_id)
        SELECT *
        FROM users
        WHERE id = ?
      SQL
      return nil unless author.length.positive?
  
      User.new(author.first)
    end
  
    def question
      question = QuestionsDatabase.instance.execute(<<-SQL, subject_question)
        SELECT *
        FROM questions
        WHERE id = ?
      SQL
      return nil unless question.length.positive?
  
      Question.new(question.first)
    end
  
    def parent_reply
      parent = QuestionsDatabase.instance.execute(<<-SQL, parent_reply_id)
        SELECT *
        FROM replies
        WHERE id = ?
      SQL
      return nil unless parent.length.positive?
  
      Replies.new(parent.first)
    end
  
    def child_reply
      child = QuestionsDatabase.instance.execute(<<-SQL, id)
        SELECT *
        FROM replies
        WHERE parent_reply_id = ?
      SQL
      return nil unless child.length.positive?
  
      Replies.new(child.first)
    end
  end