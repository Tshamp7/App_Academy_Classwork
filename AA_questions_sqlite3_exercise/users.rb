# returns objects constucted from the users table when queries are submitted. 
class User
    attr_accessor :id, :fname, :lname
  
    def self.all
      data = QuestionsDatabase.instance.execute('SELECT * FROM users')
      data.map { |datum| User.new(datum) }
    end
  
    def self.find_by_id(id)
      user = QuestionsDatabase.instance.execute(<<-SQL, id)
        SELECT *
        FROM users
        WHERE id = ?
      SQL
      return nil unless user.length.positive?
      User.new(user.first)
    end
  
    def self.find_by_name(fname, lname)
      user = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
        SELECT *
        FROM users
        WHERE fname = ? AND lname = ?
      SQL
      return nil unless user.length.positive?
      User.new(user.first)
    end
  
    def initialize(hash)
      @id = hash['id']
      @fname = hash['fname']
      @lname = hash['lname']
    end
  
    def insert
      raise "#{self} already in database" if self.id
      QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
        INSERT INTO 
          users (fname, lname)
        VALUES
          (?, ?)
      SQL
      self.id = QuestionsDatabase.instance.last_insert_row_id
    end
  
    def authored_replies # <<<<< Need to test this method.
      Replies.find_by_user_id(id)
    end
  
    def followed_questions
      Question_follows.followed_questions_for_user(id)
    end

    def liked_question
      Question_likes.liked_questions_for_user_id(id)
    end
  
  end