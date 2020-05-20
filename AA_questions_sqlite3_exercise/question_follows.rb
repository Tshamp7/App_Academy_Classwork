# returns objects constucted from the question_follows table when queries are submitted. 
class Question_follows
  attr_accessor :id, :users_question_id, :question_follower_id

  def self.followers_for_question(question_id)
    question_followers = QuestionsDatabase.instance.execute(<<-SQL, question_id: question_id)
      SELECT users.*
      FROM users
      JOIN questions_follows
        ON users.id = questions_follows.question_follower_id
      WHERE questions_follows.users_question_id = :question_id
    SQL
    return nil unless question_followers.length.positive?

    question_followers.map { |datum| User.new(datum) }
  end

def self.nth_most_followed_questions(n)
  most_followed_questions = QuestionsDatabase.instance.execute(<<-SQL, limit: n)
   SELECT *
   FROM questions
   JOIN questions_follows
     ON questions.id = questions_follows.users_question_id
   GROUP BY questions.id
   LIMIT :limit
  SQL

  most_followed_questions.map { |datum| Question.new(datum) }
end

  def self.followed_questions_for_user(user_id)
    followed_questions = QuestionsDatabase.instance.execute(<<-SQL, user_id: user_id)
      SELECT questions.*
      FROM questions
      JOIN questions_follows
        ON questions.id = questions_follows.users_question_id
      WHERE questions_follows.question_follower_id = :user_id
    SQL
    return nil unless followed_questions.length.positive?

    followed_questions.map { |datum| Question.new(datum) }
  end

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

  def insert
    QuestionsDatabase.instance.execute(<<-SQL, users_question_id, question_follower_id)
      INSERT INTO questions_follows (users_question_id, question_follower_id)
      VALUES (?, ?)
    SQL
    self.id = QuestionsDatabase.instance.last_insert_row_id
  end


end