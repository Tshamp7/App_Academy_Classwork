require_relative 'slideable'
require_relative 'piece'
class Queen < Piece
    include Slideable
  attr_accessor :pos
  attr_reader :color, :board, :symbol

  def initialize(color, board, pos)
    @color = color
    @board = board
    @pos = pos
    @symbol = :Q
  end

  def move_dirs
    horizontal_and_vertical_dirs + diagonal_dirs
  end
  
end

