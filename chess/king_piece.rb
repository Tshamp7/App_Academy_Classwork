require_relative 'piece'
require_relative 'stepable'
class King < Piece
    include Stepable
    attr_reader :color, :board, :pos, :symbol
    attr_writer :pos
    def initialize(color, board, pos)
        @color = color
        @board = board
        @pos = pos
        @symbol = :K
    end

    def move_type
        king_move_set
    end



end