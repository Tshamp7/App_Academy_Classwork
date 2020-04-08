require_relative 'piece'
require_relative 'stepable'
require 'colorize'

class Knight < Piece
  include Stepable
  attr_reader :color, :board, :pos, :symbol
  attr_writer :pos
  def initialize(color, board, pos)
    @color = color
    @board = board
    @pos = pos
    @symbol = color_symbol
  end  
  def color_symbol
    if color == :white
      @symbol = :k.to_s.white
    else
      @symbol = :k.to_s.red
    end
  end  
  def move_type
    knight_move_set
  end

end