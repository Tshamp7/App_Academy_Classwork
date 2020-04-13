require_relative 'null_piece'
require_relative 'piece'
require_relative 'bishop_piece'
require_relative 'rook_piece'
require_relative 'knight_piece'
require_relative 'queen_piece'
require_relative 'king_piece'
require_relative 'pawn_piece'
require_relative 'null_piece'
require_relative 'slideable'
require_relative 'cursor'
require_relative 'board'
require 'colorize'
require 'duplicate'

class Display
    attr_reader :board, :cursor
  def initialize(board)
    @chess_board = board
    pos = [0, 0]
    @cursor = Cursor.new(pos, board)
  end

  def build_grid
    @chess_board.board.map.with_index do |row, i|
      build_row(row, i)
    end
  end

  def build_row(row, i)
    row.map.with_index do |piece, j|
      color_options = colors_for(i, j)
      piece.symbol.colorize(color_options)
    end
  end

  def colors_for(i, j)
    if cursor.cursor_pos == [i, j] && cursor.selected
        bg = :light_yellow
    elsif cursor.cursor_pos == [i, j]
      bg = :light_red
    elsif (i + j).odd?
      bg = :light_blue
    else
      bg = :light_green
    end
    { background: bg }
  end

  def render
    system('clear')
    puts 'Arrow keys, WASD, or vim to move, space or enter to confirm.'
    build_grid.each { |row| puts row.join }
  end

  def test_cursor
    loop do
    render
    self.cursor.get_input
    end
  end


end

# game = Display.new(Board.new)


# game.test_cursor




