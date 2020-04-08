require_relative 'slideable'
require 'colorize'

class Rook < Piece
  include Slideable
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
      @symbol = :b.to_s.white
    else
      @symbol = :b.to_s.red
    end
  end  
  def move_dirs
    horizontal_and_vertical_dirs
  end
end