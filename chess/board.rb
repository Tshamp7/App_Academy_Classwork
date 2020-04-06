require_relative "null_piece"
require_relative "piece"
require_relative "bishop_piece"
require_relative "rook_piece"
require_relative "knight_piece"
require_relative "queen_piece"
require_relative "king_piece"
require_relative "pawn_piece"
require_relative "null_piece"


class Board
    attr_reader :board
    attr_writer :board
    def initialize
        @board = Array.new(8) { Array.new(8) }
    end

    def place_rook
        white_rooks = [[0, 0], [0, 7]]
        white_rooks.each do |coord|
            self.place_piece(coord, Rook.new(:white, self, coord))
        end
        black_rooks = [[7, 0], [7, 7]]
        black_rooks.each do |coord|
            self.place_piece(coord, Rook.new(:black, self, coord))
        end
    end

    def place_knight
        white_knights = [[0, 1], [0, 6]]
        white_knights.each do |coord|
            self.place_piece(coord, Knight.new(:white, self, coord))
        end
        black_knights = [[7, 1], [7, 6]]
        black_knights.each do |coord|
            self.place_piece(coord, Knight.new(:black, self, coord))
        end
    end

    def place_bishop
        white_bishops = [[0, 2], [0, 5]]
        white_bishops.each do |coord|
            self.place_piece(coord, Bishop.new(:white, self, coord))
        end
        black_bishops = [[7, 2], [7, 5]]
        black_bishops.each do |coord|
            self.place_piece(coord, Bishop.new(:black, self, coord))
        end
    end

    def place_royalty
        self.place_piece([0, 3], Queen.new(:white, self, [0, 3]))
        self.place_piece([0, 4], King.new(:white, self, [0, 4]))

        self.place_piece([7, 3], Queen.new(:black, self, [7, 3]))
        self.place_piece([7,4], King.new(:black, self, [7, 4]))
    end

    def place_pawns
        @board.each_with_index do |row, idx|
            row.each_index do |idx2|
                if idx == 1
                    self.board[idx][idx2] = Pawn.new(:white, self, [idx, idx2])
                elsif idx == 6
                    self.board[idx][idx2] = Pawn.new(:black, self, [idx, idx2])
                end
            end
        end
    end

    def place_null
        @board.each_with_index do |row, idx|
            row.each_index do |idx2|
                if idx == 2 || idx == 3 || idx == 4 || idx == 5
                    self.board[idx][idx2] = NullPiece.new
                end
            end
        end
    end

    def move_piece(start_pos, end_pos)
        raise ArgumentError.new("There is no piece to move at #{start_pos}.") if self.board[start_pos[0]][start_pos[1]].is_a?(NullPiece)
        raise ArgumentError.new("The ending position #{end_pos} is not valid.") if self.board[end_pos[0]][end_pos[1]].symbol != " "

        self.board[end_pos[0]][end_pos[1]] = self.board[start_pos[0]][start_pos[1]] 
        self.board[start_pos[0]][start_pos[1]] = NullPiece.new
    end

    def place_piece(arr, piece)
        row = arr[0]
        col = arr[1]
        self.board[row][col] = piece
    end

    def populate_board
        self.place_rook
        self.place_knight
        self.place_bishop
        self.place_royalty
        self.place_pawns
        self.place_null
    end

    def render
        puts "  #{(0..7).to_a.join("|")}"
        self.board.each_with_index do |row, i|
            puts "#{i}|#{self.board[i].map(&:symbol).join("|")}"
        end
    end

    def dup_board
        dup_board = []
        self.board.each do |row|
            dup_board << row
        end
        dup_board
    end








end

new_board = Board.new

new_board.populate_board

new_board.render



start_pos = [0, 0]
end_pos = [4, 0]

new_board.move_piece(start_pos, end_pos)

new_board.render


