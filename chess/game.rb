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
require_relative 'display'
require_relative 'human_player'
require 'colorize'
require 'duplicate'

class Game
  attr_accessor :board, :game_over, :player1, :player2, :display, :current_player
  def initialize(name1, name2)
    @board = Board.new
    @display = Display.new(board)
    @player1 = HumanPlayerWhite.new(name1, display)
    @player2 = HumanPlayerBlack.new(name2, display)
    @game_over = false
    @current_player = player1
  end

  def check_mate?
    black_king = board.find_king(:black)
    white_king = board.find_king(:white)

    if board[black_king].moves.eql?(board.in_check_move(board[black_king]))
        unless board[black_king].moves.empty?
          puts "#{player1.name} wins the game!"
          @game_over = true
        end
    elsif board[white_king].moves.eql?(board.in_check_move(board[white_king]))
        unless board[white_king].moves.empty?
          puts "#{player2.name} wins the game!"
          @game_over = true
        end
    end
  end

  def won?
    if board.find_king(:white) == false
        puts "Checkmate! #{player2.name} has won!"
        @game_over = true
    end

    if board.find_king(:black) == false
        puts "Checkmate! #{player1.name} has won!"
        @game_over = true
    end
  end

  def change_current_player
    if @current_player == player1
      @current_player = player2
    else
      @current_player = player1
    end
  end


  def king_tie?
    count = 0
    board.board.each do |row|
        row.each do |piece|
            count += 1 if piece.color != nil
        end
    end

    if count == 2 && (!board.find_king(:white) && !board.find_king(:black))
        puts "The game has ended in an all Kings tie!"
        @game_over = true
    end
  end

  def play_game
    loop do
      display.render
      puts "#{current_player.name}: #{current_player.color}, make your move!"
      change_current_player if current_player.make_move
      won?
      king_tie?
      check_mate?
      break if game_over
    end
  end


end

my_game = Game.new("Tom", "Kai")


my_game.play_game