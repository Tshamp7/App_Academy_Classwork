
# returns objects constucted from the question_likes table when queries are submitted. 
class Question_likes
    attr_accessor :id, :user_id, :liked_question_id
  
    def self.likers_for_question(liked_question_id)
        likers = QuestionsDatabase.instance.execute(<<-SQL, liked_question_id: liked_question_id )
          SELECT users.*
          FROM users
          JOIN question_likes
            ON question_likes.user_id = users.id
          WHERE :liked_question_id = question_likes.liked_question_id
        SQL
        return nil unless likers.length.positive?
        
        likers.map { |datum| User.new(datum) }
    end

    def self.num_likes_for_question(liked_question_id)
      likes_for_question = QuestionsDatabase.instance.execute(<<-SQL, liked_question_id: liked_question_id)
      SELECT COUNT(*) AS num_likes
      FROM question_likes
      WHERE :liked_question_id = question_likes.liked_question_id
      SQL
      return nil unless likes_for_question.length.positive?

      likes_for_question.first['num_likes']
    end

    def self.liked_questions_for_user_id(passed_in_id)
      liked_questions = QuestionsDatabase.instance.execute(<<-SQL, passed_in_id)
        SELECT * 
        FROM questions
        WHERE questions.id IN (
          SELECT liked_question_id
          FROM question_likes
          WHERE question_likes.user_id = ?
        )
      SQL
      return nil unless liked_questions.length.positive?
      liked_questions.map { |datum| Question.new(datum) }
    end

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