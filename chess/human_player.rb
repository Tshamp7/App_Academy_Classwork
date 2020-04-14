require_relative 'null_piece'
require_relative 'piece'
require_relative 'bishop_piece'
require_relative 'rook_piece'
require_relative 'knight_piece'
require_relative 'queen_piece'
require_relative 'king_piece'
require_relative 'pawn_piece'
require_relative 'null_piece'
require_relative 'slideable'
require_relative 'cursor'
require_relative 'board'
require_relative 'display'
require 'colorize'
require 'duplicate'

# contains logic for human player class.
class HumanPlayerWhite
    attr_reader :color, :display, :name
  def initialize(name, display)
    @name = name
    @display = display
    @color = :white
  end

  def make_move
    display.cursor.get_input
  end

end

class HumanPlayerBlack
  attr_reader :color, :display, :name
  def initialize(name, display)
    @name = name
    @display = display
    @color = :black
  end

  def make_move
    display.cursor.get_input
  end

end
