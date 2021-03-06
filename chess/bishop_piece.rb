require_relative 'slideable'
require 'colorize'

class Bishop < Piece
  include Slideable
  attr_reader :color, :board, :pos, :symbol, :prev_pos, :last_capture
  attr_writer :pos, :prev_pos, :last_capture
  def initialize(color, board, pos)
    @color = color
    @board = board
    @pos = pos
    @symbol = color_symbol
    @prev_pos = nil
    @last_capture = nil
  end  
  def color_symbol
    if color == :white
      @symbol = :b.to_s.white + ' '
    else
      @symbol = :b.to_s.black + ' '
    end
  end  

  def move_dirs
    diagonal_dirs
  end
end