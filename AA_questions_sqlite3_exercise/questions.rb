

# return obbjects constructed from the questions table when queries are submitted.
class Question
    attr_accessor :id, :title, :body, :author_id

    def self.most_followed
      Question_follows.nth_most_followed_questions(1)
    end
  
    def self.all
      data = QuestionsDatabase.instance.execute('SELECT * FROM questions')
      data.map { |datum| Question.new(datum) }
    end
  
    def self.find_by_id(id)
      question = QuestionsDatabase.instance.execute(<<-SQL, id)
        SELECT *
        FROM questions
        WHERE id = ?
      SQL
      return nil unless question.length.positive?
  
      Question.new(question.first)
    end
  
    def self.find_by_author_name(fname, lname)
      author = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
        SELECT *
        FROM questions
        WHERE id = (
            SELECT id
            FROM users
            WHERE fname = ? AND lname = ?
        )
      SQL
      return nil unless author.length.positive?
  
      author.map { |datum| Question.new(datum) }
    end
  
    def self.find_by_author_id(id)
      question = QuestionsDatabase.instance.execute(<<-SQL, id)
        SELECT *
        FROM questions
        WHERE author_id = ?
      SQL
      return nil unless question.length.positive?
  
      question.map { |datum| Question.new(datum) }
    end
  
    def initialize(hash)
      @id = hash["id"]
      @title = hash["title"]
      @body = hash["body"]
      @author_id = hash["author_id"]
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
  
    def replies
      Replies.find_by_question_id(id)
    end
  
    def followers
      Question_follows.followers_for_question(self.id)
    end

  end


