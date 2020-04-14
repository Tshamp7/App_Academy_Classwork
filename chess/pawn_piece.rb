require_relative "piece"
require 'colorize'
require 'duplicate'

class Pawn < Piece
  attr_reader :color, :board, :pos, :symbol, :start_pos, :prev_pos, :last_capture
  attr_writer :pos, :prev_pos, :last_capture
  def initialize(color, board, pos)
    @color = color
    @board = board
    @pos = pos
    @start_pos = pos
    @symbol = color_symbol
    @prev_pos = nil
    @last_capture = nil
  end
  def color_symbol
    if color == :white
      @symbol = :p.to_s.white + ' '
    else
      @symbol = :p.to_s.black + ' '
    end
  end  
 
  BLACK_DIRS = [
      [-1, 0],
      [-2, 0],
      [-1, 1],
      [-1, -1]
  ]  
  WHITE_DIRS = [
      [1, 0],
      [2, 0],
      [1, -1],
      [1, 1]
  ]  
  def moves
    moves = []  
      if color == :white
        allow_moves = WHITE_DIRS
      else
        allow_moves = BLACK_DIRS
      end
      allow_moves.each do |row, col|
        moves.concat(find_moves_in_dir(row, col))
      end
      moves
  end  
  def find_moves_in_dir(row, col)
      cur_row = pos[0]
      cur_col = pos[1]
      moves = []
      cur_row += row
      cur_col += col  
      position = [cur_row, cur_col]
      if board.valid_pos?(position)
        if board.is_empty?(position)
          if [1, -1].include?(row) && col.zero? || [2, -2].include?(row) && pos == start_pos
            moves << position
          end
        else
          if board[position].color != color && col == 1 || col == -1
            moves << position
          end
        end
      end
      moves
  end

end