require_relative 'slideable'
class Bishop < Piece
    include Slideable
    attr_reader :color, :board, :pos, :symbol
    attr_writer :pos
    def initialize(color, board, pos)
        @color = color
        @board = board
        @pos = pos
        @symbol = :b
    end

    def move_dirs
        diagonal_dirs
    end
end