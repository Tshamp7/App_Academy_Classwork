require_relative 'piece'
require_relative 'stepable'
require 'colorize'

class King < Piece
    include Stepable
    attr_reader :color, :board, :pos, :symbol
    attr_writer :pos
    def initialize(color, board, pos)
        @color = color
        @board = board
        @pos = pos
        @symbol = color_symbol
    end

    def color_symbol
        if color == :white
            @symbol = :K.to_s.white
        else
            @symbol = :K.to_s.red
        end
    end

    def move_type
        king_move_set
    end



end