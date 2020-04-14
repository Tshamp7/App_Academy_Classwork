require_relative 'piece'
require_relative 'stepable'
require 'colorize'

class Knight < Piece
  include Stepable
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
      @symbol = :k.to_s.white + ' '
    else
      @symbol = :k.to_s.black + ' '
    end
  end  
  def move_type
    knight_move_set
  end

end