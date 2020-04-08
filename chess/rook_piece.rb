require_relative 'slideable'
class Rook < Piece
    include Slideable
    attr_reader :color, :board, :pos, :symbol
    attr_writer :pos
    def initialize(color, board, pos)
        @color = color
        @board = board
        @pos = pos
        @symbol = :r
    end

    def move_dirs
        horizontal_and_vertical_dirs
    end
end