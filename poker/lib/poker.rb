require 'byebug'

class Card
  attr_reader :suit, :value, :face_value
  def initialize(suit, value)
    @suit = suit
    @value = value
    @face_value = "#{value} of #{suit}"
  end
end

class Deck
  attr_accessor :deck, :suits, :values
  def initialize
    @deck = []
    @suits =  %w[hearts clubs diamonds spades]
    @values = %w[A 2 3 4 5 6 7 8 9 10 J Q K]
  end

  def build_deck
    suits.each_with_index do |suit, idx|
      values.each_with_index do |value, idx2|
        card = Card.new(suit, value)
        @deck << card
      end
    end
  end

  def shuffle
   5.times { @deck.shuffle! }
  end
end

class Hand
  attr_accessor :cards, :type, :winning_hand, :highest_card
  attr_reader :flushes, :hand_rankings, :card_nums
  def initialize
    @cards = []
    @type = nil
    @flushes = [%w[2 3 4 5 A],  
                %w[2 3 4 5 6], 
                %w[3 4 5 6 7], 
                %w[4 5 6 7 8], 
                %w[5 6 7 8 9], 
                %w[10 6 7 8 9], 
                %w[10 7 8 9 J], 
                %w[10 8 9 J Q],
                %w[10 9 J K Q]]
    @winning_hand = false
    @hand_rankings = ['Royal Flush',
                      'Flush',
                      'four-of-a-kind',
                      'three-of-a-kind',
                      'pair', nil].freeze
    @card_nums = {'A'=>1, 
                  '2'=>2, 
                  '3'=>3, 
                  '4'=>4, 
                  '5'=>5, 
                  '6'=>6, 
                  '7'=>7, 
                  '8'=>8, 
                  '9'=>9, 
                  '10'=>10, 
                  'J'=>11, 
                  'Q'=>12, 
                  'K'=>13}
    @highest_card = 0
  end

  def calculate_hand
    values = find_values
    suits = find_suits


    if suits.uniq.length == 1 && values.sort == %w[10 A J K Q]
      self.type = 'Royal Flush'
    end

    if flushes.include?(values.sort) && suits.uniq.length == 1
      self.type = 'flush'
    end

    if values.uniq.length == 2
      self.type = 'four-of-a-kind' 

    elsif values.uniq.length == 3
      self.type = 'three-of-a-kind' 

    elsif values.uniq.length == 4
      self.type = 'pair'
    else
      self.type = nil
    end

  end

  def find_values
    output = []
    cards.each do |card|
      output << card.value
    end
    output
  end

  def find_suits
    output = []
    cards.each do |card|
      output << card.suit
    end
    output
  end

  def cards_info
    output = []
    cards.each do |card|
      if card == nil
        output << nil
      else
        output << card.face_value
      end
    end
    output
  end

  def calculate_highest_card
    card_numbers = []
    values = find_values
    values.each do |value|
      card_numbers << @card_nums[value]
    end
    @highest_card = card_numbers.max
  end

  def winning_hand?(other_hand)
    other_hand.calculate_hand
    calculate_hand
    if hand_rankings.index(type) < hand_rankings.index(other_hand.type)
      @winning_hand = true
      true
    end
  end
end

class Player
  attr_accessor :hand, :pot
  attr_reader :name
  def initialize(name)
    @name = name
    @hand = Hand.new
    @pot = 500
  end

  class InvalidCardError < StandardError
    def message 
      'Your entry contains invalid index positions. Please use valid index positions.'
    end
  end

  def discard(card1 = nil)
    if (0..4).include?(card1) && !card1.nil?
      hand.cards.delete_at(card1)
    else
        raise InvalidCardError
    end
  end

  def input_for_discard
    discard = true
    discarded = 0

    while discard
      if discarded == 3
        puts 'Maximum discard limit reached.'
        break
      end

      puts "would you like to discard a card? Please enter 'yes' or 'no'."
      yes_or_no = gets.chomp
      break unless yes_or_no == 'yes'

      discarded += 1
  
      hand.cards_info.each_with_index do |card, i|
        puts "index: #{i} card: #{card}"
      end
  
      puts 'Please enter the index position of the card you would like to discard.'
      card = gets.chomp.to_i
      discard(card)
    end
  end

  def fold_see_raise
    puts "Would you like to fold, call, or raise? Enter 'fold', 'call', or raise'."
    input = gets.chomp
    input
  end
end

class Game
  attr_reader :players, :deck, :turn, :pot, :buy_in_amount, :current_bet, :called, :high_bet_placer, :original_players
  attr_writer :players, :turn, :pot, :buy_in_amount, :current_bet, :called, :high_bet_placer
  def initialize(*player_names)
    @players = player_names.map { |player_name| Player.new(player_name) }
    @original_players = player_names.to_a
    @deck = Deck.new
    @turn = players[0]
    @pot = 0
    @game_over = false
    @buy_in_amount = 50
    @current_bet = 0
    @called = false
    @high_bet_placer = nil
  end

  def change_turn
    @players.rotate!
    @turn = players[0]
  end

  def display_pot
    pot
  end

  def fold
    @players.delete(@turn)
    @turn = players[0]
  end

  def get_fold_see_raise
    case @turn.fold_see_raise
    when 'fold'
      puts "#{turn.name} has folded!"
      fold
      return false
    when 'call'
      call
    when 'raise'
      raise_bet
    end
  end

  def bet
    puts "#{turn.name}, please enter your bet."
    amount = gets.chomp.to_i
    puts "#{turn.name} bets #{amount}!"
    @current_bet = amount
    @pot += amount
    @turn.pot -= amount
    @high_bet_placer = @turn
  end

  def call
    puts "#{turn.name} has called and matched the bet placed by #{high_bet_placer.name}."
    turn.pot -= @current_bet
    @pot += current_bet
    @called = true if @called == false
  end

  def raise_bet
    puts 'How much would you like to raise?'
    amount = gets.chomp.to_i
    puts "#{turn.name} raises #{amount}!"
    @pot += amount
    @turn.pot -= amount
    @current_bet += amount
    @high_bet_placer = @turn
    @called = true
  end

  def deal
    until players.all? { |player| player.hand.cards.length == 5 }
      @players.each do |player|
        deck_cards = deck.deck
        players_hand = player.hand.cards
        players_hand << deck_cards.pop if players_hand.length < 5
      end
    end
  end

  def find_best_hand
    hand_ranks = {}
    card_nums = {}
    no_hand_type_nums = {}
    players.each do |player|
      players_hand = player.hand
      players_hand.calculate_hand
      players_hand.calculate_highest_card
      if !players_hand.type.nil?
        hand_ranks[player] = players_hand.hand_rankings.index(players_hand.type)
        card_nums[player] = players_hand.highest_card
      end
      if players_hand.type == nil
        no_hand_type_nums[player] = players_hand.highest_card
      end
       
    end
    
    if hand_ranks.size > 1 && hand_ranks.values.uniq.length == 1
      return card_nums.key(card_nums.values.max)
    end
  
    if hand_ranks.values.count(hand_ranks.values.min) == 1
      return hand_ranks.key(hand_ranks.values.min)
    end

    if hand_ranks.values.count(hand_ranks.values.min) > 1
      return card_nums.key(card_nums.values.max)
    end

    return no_hand_type_nums.key(no_hand_type_nums.values.max) if hand_ranks.empty?
  end

  def assign_winnings
    if @players.length == 1
      puts "#{@players[0].name} has won the game! and takes home the pot of #{@pot}!"
      winning_player = @players[0]
      winning_player.pot += @pot
      @pot = 0
    elsif @called == true
      winning_player = find_best_hand
      winning_player.pot += @pot
      @pot = 0
    else
      winning_player = @high_bet_placer
      winning_player.pot += @pot
      @pot = 0
    end
  end

  def play_game
    deck.build_deck
    deck.shuffle
    deal
    buy_in
    take_turn = 0
    until @game_over
     
     puts "#{turn.name} your cards are: #{turn.hand.cards_info}"
     @turn.input_for_discard
     deal

     if current_bet.zero?
       bet
       change_turn
     else 
       if get_fold_see_raise == false
         if @players.length == 1
            @game_over = true
            assign_winnings
         end
       else
         take_turn += 1
         change_turn
       end
       take_turn += 1
     end
    end

    if take_turn == players.length
      if @called == false
        @game_over = true
        assign_winnings
        if @players.all? { |player| player.pot >= 50 }
          @game_over = false
          reset_game
          play_game
        end
      else
        assign_winnings
      end
    end
  end

  def buy_in
    players.each do |player|
      player.pot -= 50
      @pot += 50
    end
  end

  def empty_hands
    @players.each do |player|
      player.hand = Hand.new
    end
  end

  def reset_game
    empty_hands
    @players = original_players.map { |player_name| Player.new(player_name) }
    @called = false
    @high_bet_placer = false
    play_game
  end


end

my_game = Game.new('Tom', 'Amber', 'Kai', 'Joe')

my_game.play_game