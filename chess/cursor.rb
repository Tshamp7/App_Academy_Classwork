require "io/console"
require_relative 'board'
require 'duplicate'
KEYMAP = {
  " " => :space,
  "h" => :left,
  "j" => :down,
  "k" => :up,
  "l" => :right,
  "w" => :up,
  "a" => :left,
  "s" => :down,
  "d" => :right,
  "\t" => :tab,
  "\r" => :return,
  "\n" => :newline,
  "\e" => :escape,
  "\e[A" => :up,
  "\e[B" => :down,
  "\e[C" => :right,
  "\e[D" => :left,
  "\177" => :backspace,
  "\004" => :delete,
  "\u0003" => :ctrl_c,
}

MOVES = {
  left: [0, -1],
  right: [0, 1],
  up: [-1, 0],
  down: [1, 0]
}

class Cursor

  attr_reader :board
  attr_accessor :selected, :current_piece, :cursor_pos

  def initialize(cursor_pos, board)
    @cursor_pos = cursor_pos
    @board = board
    @selected = false
    @current_piece = nil
  end

  def get_input
    key = KEYMAP[read_char]
    handle_key(key)
  end


  def handle_key(key)
    case key
    when :return || :space
      if @selected == false
        @selected = true
        @current_piece = board[cursor_pos]
      else
        @selected = false
      end

      if @selected == false #&& board.is_empty?(@cursor_pos)
        @board.move_piece(@current_piece.color, @current_piece.pos, cursor_pos)
      end
    when :up
      update_pos(MOVES[:up])
      nil
    when :down
      update_pos(MOVES[:down])
      nil
    when :right
      update_pos(MOVES[:right])
      nil
    when :left
      update_pos(MOVES[:left])
      nil
    when :ctrl_c
      Process.exit(0)
    end
  end

  class InvalidCursorPos < StandardError
    def message
      puts "That is not a valid board position. Please keep the cursor on the chess board."
      sleep(2)
    end
  end



  def update_pos(diff)
     new_row = cursor_pos[0] + diff[0]
     new_col = cursor_pos[1] + diff[1]
    if board.valid_pos?(@cursor_pos)
      @cursor_pos = [new_row, new_col]
    else
      begin
        raise InvalidCursorPos
      rescue InvalidCursorPos => e
        e.message
        self.cursor_pos = [0, 0]
      end
    end
  end

  private

  def read_char
    STDIN.echo = false # stops the console from printing return values

    STDIN.raw! # in raw mode data is given as is to the program--the system
                 # doesn't preprocess special characters such as control-c

    input = STDIN.getc.chr # STDIN.getc reads a one-character string as a
                             # numeric keycode. chr returns a string of the
                             # character represented by the keycode.
                             # (e.g. 65.chr => "A")

    if input == "\e" then
      input << STDIN.read_nonblock(3) rescue nil # read_nonblock(maxlen) reads
                                                   # at most maxlen bytes from a
                                                   # data stream; it's nonblocking,
                                                   # meaning the method executes
                                                   # asynchronously; it raises an
                                                   # error if no data is available,
                                                   # hence the need for rescue

      input << STDIN.read_nonblock(2) rescue nil
    end

    STDIN.echo = true # the console prints return values again
    STDIN.cooked! # the opposite of raw mode :)

    return input
  end


end






