class Simon
  COLORS = [:red, :blue, :yellow, :green]

  attr_accessor :sequence_length, :game_over, :seq, :user_seq, :high_score

  def initialize
    @colors = [:red, :blue, :yellow, :green]
    @user_seq = []
    @seq = []
    @game_over = false
    @sequence_length = 0
    @high_score = 0
  end

  def play
    take_turn until @game_over
  end

  def take_turn
    loop do
      @user_seq = []
       show_sequence
       
       while user_seq.size < seq.size
        input = require_sequence 
        @user_seq << input
       end

      if seq != user_seq
        game_over_message
        sleep(3)
        @game_over = true
        reset_game 
        take_turn
      else
        round_success_message
      end
    end

      

  end

  def show_sequence
    add_random_color
    puts "Get ready! I am going to show you the color sequence you need to remember..."
    sleep(2)
    (0...sequence_length).each do |idx|
      puts "#{seq[idx]}"
      sleep(1)
      system("clear")
      sleep(1)
    end
  end

  def require_sequence
    puts "Enter your color sequence, one color at a time."
    output = gets.chomp.to_sym
    output
  end

  def add_random_color
    COLORS.shuffle!
    seq << COLORS[0]
    @sequence_length += 1
  end

  def round_success_message
    puts "You won this round!"
    @high_score = sequence_length
    puts "Your highest score is #{@high_score}"
    sleep(2)
    system("clear")
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