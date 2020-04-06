class Bishop < Piece
    attr_reader :color, :board, :pos
    attr_writer :pos
    def initialize(color, board, pos)
        @color = color
        @board = board
        @pos = pos
    end
end