require_relative 'piece'
require_relative 'stepable'
require 'colorize'

class King < Piece
    include Stepable
    attr_reader :color, :board, :pos, :symbol, :prev_pos, :last_capture
    attr_writer :pos, :prev_pos, :last_capture
    def initialize(color, board, pos)
        @color = color
        @board = board
        @pos = pos
        @symbol = color_symbol
        @prev_pos = nil
        @last_capture = nil
    end

    def color_symbol
        if color == :white
            @symbol = :K.to_s.white + ' '
        else
            @symbol = :K.to_s.black + ' '
        end
    end

    def move_type
        king_move_set
    end



end