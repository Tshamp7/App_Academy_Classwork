require_relative "null_piece"
require_relative "piece"


class Board
    attr_accessor :board
    def initialize
        @board = Array.new(8) { Array.new(8) }
    end

    def populate 
        

    end

    def place_rook
        white_rooks = [[0, 0], [0, 7]]
        white_rooks.each do |coord|
            self.board.place_piece(coord, Rook.new(:white, self, coord))
        end
        black_rooks = [[7, 0], [7, 7]]
        black_rooks.each do |coord|
            self.board.place_piece(coord, Rook.new(:black, self, coord))
        end
    end

    def place_knight
        white_knights = [[0, 1], [0, 6]]
        white_knights.each do |coord|
            self.board.place_piece(coord, Knight.new(:white, self, coord))
        end
        black_knights = [[7, 1], [7, 6]]
        black_knights.each do |coord|
            self.board.place_piece(coord, Knight.new(:black, self, coord))
        end
    end

    def place_bishop
        white_bishops = [[0, 2], [0, 5]]
        white_bishops.each do |coord|
            self.board.place_piece(coord, Bishop.new(:white, self, coord))
        end
        black_bishops = [[7, 2], [7, 5]]
        black_bishops.each do |coord|
            self.board.place_piece(coord, Bishop.new(:black, self, coord))
        end
    end

    def place_royalty
        white_queen = self.board.place_piece([0, 3], Queen.new(:white, self, [0, 3]))
        white_king = self.board.place_piece([0, 4], King.new(:white, self, [0, 4]))

        black_queen = self.board.place_piece([7, 3], Queen.new(:black, self, [7, 3]))
        black_king = self.board.place_piece([7,4)], King.new(:black, self, [7, 4]))
    end




    def move_piece(start_pos, end_pos)
        raise ArgumentError.new("There is no piece to move at #{start_pos}.") if @self.board[start_pos].is_a?(NullPiece)
        raise ArgumentError.new("The ending position #{end_pos} is not valid.") if self.board[end_pos].is_a?(Piece)

        self.board[end_pos[0]][end_pos[1]] = self.board[start_pos[0]][start_pos[1]] 
        self.board[start_pos[0]][start_pos[1]] = NullPiece.new(nil, self, [start_pos[0], start_pos[1]])
    end

    def place_piece(arr, piece)
        row = arr[0]
        col = arr[1]
        self.board[row][col] = piece
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