require_relative "piece"

class NullPiece < Piece
    attr_reader :symbol
    def initialize(color, board, pos)
        @color = color
        @board = board
        @pos = pos
    end

end