require_relative "piece"
require 'colorize'
require 'duplicate'

class Pawn < Piece
  attr_reader :color, :board, :pos, :symbol, :start_pos, :prev_pos
  attr_writer :pos, :prev_pos
  def initialize(color, board, pos)
    @color = color
    @board = board
    @pos = pos
    @start_pos = pos
    @symbol = color_symbol
    @prev_pos = nil
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
      pos = [cur_row, cur_col]
      if board.valid_pos?(pos)
        if board.is_empty?(pos)
          if (col.zero?) && [1, -1].include?(row)
            moves << pos 
          elsif row > 1 && pos == start_pos
            moves << pos 
          end
        else
          if board[pos].color != color && col == 1 || col == -1
            moves << pos 
          end
        end
      end
      moves
  end

end