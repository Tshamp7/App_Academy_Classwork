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
require 'byebug'
require 'colorize'
require 'duplicate'

# contains logic for the chess board.
class Board
  attr_reader :board
  attr_writer :board
  def initialize
    @board = Array.new(8) { Array.new(8) }
    populate_board
  end

  def [](pos)
    row = pos[0]
    col = pos[1]

    board[row][col] 
  end

  def []=(pos, value)
    row = pos[0]
    col = pos[1]

    board[row][col] = value
  end

  def place_rook
    white_rooks = [[0, 0], [0, 7]]
    white_rooks.each do |coord|
      place_piece(coord, Rook.new(:white, self, coord))
    end
    black_rooks = [[7, 0], [7, 7]]
    black_rooks.each do |coord|
      place_piece(coord, Rook.new(:black, self, coord))
    end
  end

  def place_knight
    white_knights = [[0, 1], [0, 6]]
    white_knights.each do |coord|
      place_piece(coord, Knight.new(:white, self, coord))
    end
    black_knights = [[7, 1], [7, 6]]
    black_knights.each do |coord|
      place_piece(coord, Knight.new(:black, self, coord))
    end
  end

  def place_bishop
    white_bishops = [[0, 2], [0, 5]]
    white_bishops.each do |coord|
      place_piece(coord, Bishop.new(:white, self, coord))
    end
    black_bishops = [[7, 2], [7, 5]]
    black_bishops.each do |coord|
      place_piece(coord, Bishop.new(:black, self, coord))
    end
  end

  def place_royalty
    place_piece([0, 3], Queen.new(:white, self, [0, 3]))
    place_piece([0, 4], King.new(:white, self, [0, 4]))

    place_piece([7, 3], Queen.new(:black, self, [7, 3]))
    place_piece([7,4], King.new(:black, self, [7, 4]))
  end

  def place_pawns
    @board.each_with_index do |row, idx|
      row.each_index do |idx2|
        if idx == 1
          pos = [idx, idx2]
          self[pos] = Pawn.new(:white, self, [idx, idx2])
        elsif idx == 6
          pos = [idx, idx2]
          self[pos] = Pawn.new(:black, self, [idx, idx2])
        end
      end
    end
  end

  def place_null
    @board.each_with_index do |row, idx|
      row.each_index do |idx2|
        if (2..5).include?(idx)
          pos = [idx, idx2]
          self[pos] = NullPiece.new
        end
      end
    end
  end

  class MoveError < StandardError
    def message
      puts "That move is not a valid move for this piece, please choose another locations."
      sleep(2)
    end
  end

  class ColorError < StandardError
    def message
      puts "That piece is not the correct color."
      sleep(2)
    end
  end

  class NoPieceError < StandardError
    def message
      puts "There is no piece to move at that locations. Please try another."
      sleep(2)
    end
  end

  class InvalidEndError < StandardError
    def message
      puts "That ending position is not valid. Please try another"
      sleep(2)
    end
  end

  class KingCheckError < StandardError
    def message
      puts "That move will place your king in check. Please try another."
      sleep(2)
    end
  end


  def move_piece(color, start_pos, end_pos)
    if self[start_pos].color != color.to_sym
      begin
      raise ColorError
      rescue ColorError => e
        e.message
      end
    elsif self[start_pos].is_a?(NullPiece)
      begin
        raise NoPieceError
        rescue NoPieceError => e
          e.message
        end
    elsif self[end_pos].symbol != '  ' && self[end_pos].color == self[start_pos].color
      begin
        raise InvalidEndError
        rescue InvalidEndError => e
          e.message
        end
    end

    if self[start_pos].moves.include?(end_pos)
      if !self.in_check_move(self[start_pos]).include?(end_pos)
        self[end_pos] = self[start_pos] 
        self[start_pos].prev_pos = start_pos
        self[start_pos] = NullPiece.new
        self[end_pos].pos = end_pos
      else
        begin
          raise KingCheckError
        rescue KingCheckError => e
          e.message
          return
        end
      end
    else
      begin
        raise MoveError
      rescue MoveError => e
        e.message
        return
      end
    end
    true
  end

  def is_empty?(pos)
    return true if board[pos[0]][pos[1]].symbol == '  '
    false
  end

  def valid_pos?(pos)
    if pos.all?{ |coord| coord.between?(0, 7) }
      return true
    end
    false
  end

  def move_piece!(start_pos, end_pos) # allows pieces to be moved without checking conditions so that moves can be evaluated for if they cause the moving player to be placed into check. 
    self[end_pos] = self[start_pos] 
    self[start_pos].prev_pos = start_pos
    self[start_pos] = NullPiece.new
    self[end_pos].pos = end_pos
  end


  def place_piece(arr, piece)
    row = arr[0]
    col = arr[1]
    board[row][col] = piece
  end

  def populate_board
    place_rook
    place_knight
    place_bishop
    place_royalty
    place_pawns
    place_null
  end

  def find_king(color)
    board.each_with_index do |row, idx|
      row.each_index do |idx2|
        pos = [idx, idx2]
        if self[pos].is_a?(King) && self[pos].color == color.to_sym
          return [idx, idx2]
        end
      end
    end
    false
  end

  def in_check?(color)
    king_pos = self.find_king(color)

    board.each do |row|
      row.each do |piece|
        if !piece.is_a?(NullPiece)
          if piece.color != color
            if piece.moves.include?(king_pos)
              return true
            end
          end
        end
      end
    end
    return false
  end

  def in_check_move(piece)
    check_moves = []
     all_moves = piece.moves
      (0...all_moves.length).each do |i|
        last_capture = self[all_moves[i]]
        move_piece!(piece.pos, all_moves[i])
        check_moves << all_moves[i] if self.in_check?(piece.color)
        move_piece!(piece.pos, piece.prev_pos)
        self[all_moves[i]] = last_capture
      end
    check_moves
  end




end

new_board = Board.new

new_board.populate_board









