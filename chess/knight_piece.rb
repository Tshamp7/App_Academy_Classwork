require_relative 'piece'
require_relative 'stepable'

class Knight < Piece
    include Stepable
    attr_reader :color, :board, :pos, :symbol
    attr_writer :pos
    def initialize(color, board, pos)
        @color = color
        @board = board
        @pos = pos
        @symbol = :k
    end

    def move_type
        knight_move_set
    end

end