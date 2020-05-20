require 'singleton'
require 'sqlite3'
require_relative 'question_follows.rb'
require_relative 'question_likes'
require_relative 'questions'
require_relative 'replies'
require_relative 'users'

# database connection
class QuestionsDatabase < SQLite3::Database
  include Singleton
  def initialize
    super('questions.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end


