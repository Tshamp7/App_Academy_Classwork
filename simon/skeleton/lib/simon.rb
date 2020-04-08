class Simon
  COLORS = [:red, :blue, :yellow, :green]

  attr_accessor :sequence_length, :game_over, :seq, :user_seq

  def initialize
    @colors = [:red, :blue, :yellow, :green]
    @user_seq = []
    @seq = []
    @game_over = false
    @sequence_length = 0
  end

  def play
    take_turn until @game_over
  end

  def take_turn
    loop do
      show_sequence
      # pick up here tomorrow.

  end

  def show_sequence
    add_random_color
    (1...seq.length).each do |idx|
      puts "#{seq[idx]}"
      sleep{1}
      system("clear")
    end
  end

  def require_sequence
    puts "Enter your color sequence, one color at a time." if user_seq.length == 0
    output = gets.chomp.to_sym
    output
  end

  def add_random_color
    COLORS.shuffle!
    seq << COLORS[0]
    @sequence_length = seq.size
  end

  def round_success_message
    puts "You won this round!"
  end

  def game_over_message
    puts "Game Over! Next time do what Simon says! (^o,..,o^) "
  end

  def reset_game
    @sequence_length = 0
    @seq = []
    @user_seq = []
    @game_over = false
  end
end

new_game = Simon.new

new_game.play
