require_relative 'slideable'
require_relative 'piece'
require 'colorize'

class Queen < Piece
    include Slideable
  attr_accessor :pos, :prev_pos, :last_capture
  attr_reader :color, :board, :symbol, :last_capture

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
        @symbol = :Q.to_s.white + ' '
    else
        @symbol = :Q.to_s.black + ' '
    end
  end

  def move_dirs
    horizontal_and_vertical_dirs + diagonal_dirs
  end

end

