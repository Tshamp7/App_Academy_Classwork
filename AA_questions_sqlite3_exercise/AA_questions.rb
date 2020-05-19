require 'singleton'
require 'sqlite3'

# database connection
class QuestionsDatabase < SQLite3::Database
  include Singleton
  def initialize
    super('questions.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

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
    p user
    User.new(user.first)
  end

  def initialize(hash)
    @id = hash['id']
    @fname = hash['fname']
    @lname = hash['lname']
  end
end

# return obbjects constructed from the questions table when queries are submitted.
class Question
  attr_accessor :id, :title, :body, :author_id

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

  def initialize(hash)
    @id = hash["id"]
    @title = hash["title"]
    @body = hash["body"]
    @author_id = hash["author_id"]
  end
end

# returns objects constucted from the question_follows table when queries are submitted. 
class Question_follows
  attr_accessor :id, :users_question_id, :question_follower_id

  def self.all
    data = QuestionsDatabase.instance.execute('SELECT * FROM questions_follows')
    data.map { |datum| Question_follows.new(datum) }
  end


  def self.find_by_id(id)
    question_follow = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT *
      FROM questions_follows
      WHERE id = ?
    SQL
    return nil unless question_follow.length.positive?
    Question_follows.new(question_follow.first)
  end

  def initialize(hash)
    @id = hash["id"]
    @users_question_id = hash["users_question_id"]
    @question_follower_id = hash["question_follower_id"]
  end
end

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

    p reply
    Replies.new(reply.first)
  end

  def initialize(hash)
    @id = hash["id"]
    @subject_question = hash["subject_question"]
    @parent_reply_id = hash["parent_reply_id"]
    @author_id = hash["author_id"]
    @body = hash["body"]
  end
end

# returns objects constucted from the question_likes table when queries are submitted. 
class Question_likes
  attr_accessor :id, :user_id, :liked_question_id

  def self.all
    data = QuestionsDatabase.instance.execute("SELECT * FROM question_likes")
    data.map { |datum| Question_likes.new(datum) }
  end

  def self.find_by_id(id)
    question_like = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT *
      FROM question_likes
      WHERE id = ?
    SQL
    return nil unless question_like.length.positive?

    Question_likes.new(question_like)
  end

  def initialize(hash)
    @id = hash['id']
    @user_id = hash['user_id']
    @liked_question_id = hash['liked_question_id']
  end
end


