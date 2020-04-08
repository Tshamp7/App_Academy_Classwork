require_relative "piece"

class Pawn < Piece
    attr_reader :color, :board, :pos, :symbol, :start_pos
    attr_writer :pos
    def initialize(color, board, pos)
        @color = color
        @board = board
        @pos = pos
        @start_pos = pos
        @symbol = :p
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
            if (col == 0) && (row == 1 || row == -1)
              moves << pos 
            elsif row > 1 && pos == start_pos
              moves << pos 
            end
          else
            moves << pos if board[pos].color != color && (col == 1 || col == -1)
          end
        end
        moves
    end



end