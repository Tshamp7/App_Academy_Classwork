
class Queen < Piece
  attr_accessor :pos
  attr_reader :color, :board, :symbol

  def initialize(color, board, pos)
    @color = color
    @board = board
    @pos = pos
    @symbol = :Q
  end

end