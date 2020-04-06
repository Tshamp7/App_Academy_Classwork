require_relative "null_piece"
require_relative "piece"


class Board
    attr_accessor :board
    def initialize
        @board = Array.new(8) { Array.new(8) }
    end

    def populate 
        @board.each_with_index do |row, idx|
            row.each_with_index do |col, idx2|
                if idx == 0 || idx == 1 || idx == 6 || idx == 7
                    @board[idx][idx2] = Piece.new
                else 
                    @board[idx][idx2] = NullPiece.new
                end

            end
        end

    end

    def move_piece(start_pos, end_pos)
        raise ArgumentError.new("There is no piece to move at #{start_pos}.") if @self.board[start_pos].is_a?(NullPiece)
        raise ArgumentError.new("The ending position #{end_pos} is not valid.") if self.board[end_pos].is_a?(Piece)

        self.board[end_pos[0]][end_pos[1]] = self.board[start_pos[0]][start_pos[1]] 
        self.board[start_pos[0]][start_pos[1]] = NullPiece.new
    end

    








end

new_board = Board.new

new_board.populate

puts new_board.board[0].map(&:symbol).join(" ")
puts new_board.board[1].map(&:symbol).join(" ")
puts new_board.board[2].map(&:symbol).join(" ")
puts new_board.board[3].map(&:symbol).join(" ")
puts new_board.board[4].map(&:symbol).join(" ")
puts new_board.board[5].map(&:symbol).join(" ")
puts new_board.board[6].map(&:symbol).join(" ")
puts new_board.board[7].map(&:symbol).join(" ")