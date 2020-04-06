class Queen < Piece
    attr_reader :color, :board, :pos, :symbol
    attr_writer :pos
    def initialize(color, board, pos)
        @color = color
        @board = board
        @pos = pos
        @symbol = :Q
    end
end