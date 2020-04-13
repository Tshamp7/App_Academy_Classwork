require_relative "piece"

class NullPiece < Piece
  attr_reader :symbol, :color
  def initialize
    @color = nil
    @board = self
    @symbol = '  '
  end

end