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
  attr_reader :deck, :suits, :values
  attr_writer :deck
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
    @deck.shuffle!
  end
end

class Hand
  attr_accessor :cards, :type, :winning_hand
  attr_reader :flushes, :hand_rankings
  def initialize
    @cards = []
    @type = nil
    @flushes = [%w[1 2 3 4 A], 
                %w[1 2 3 4 5], 
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
                      'pair'].freeze
  end

  def calculate_hand
    # debugger
    values = find_values
    suits = find_suits


    if suits.uniq.length == 1 && values.sort == %w[10 A J K Q]
      self.type = 'Royal Flush'
    end

    if flushes.include?(values.sort) && suits.uniq.length == 1
      self.type = 'flush'
    end

    self.type = 'four-of-a-kind' if values.uniq.length == 2

    self.type = 'three-of-a-kind' if values.uniq.length == 3

    self.type = 'pair' if values.uniq.length == 4

    return nil

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
      output << card.face_value
    end
    output
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
    if (0..5).include?(card1) && !card1.nil?
      hand[card1] = nil
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
    puts "Would you like to fold, see, or raise? Enter 'fold', 'see', 'raise', or 'no'."
    input = gets.chomp
    input
  end
end

class Game
  attr_reader :players, :deck, :turn, :pot
  attr_writer :players, :turn, :pot
  def initialize(*player_names)
    @players = player_names.map { |player_name| Player.new(player_name) }
    @deck = Deck.new
    @turn = players[0]
    @pot = 0
    @game_over = false
  end

  def change_turn
    @players.rotate!
    @turn = players[0]
  end

  def display_pot
    pot
  end

  def raise(amount)
    @pot += amount
    turn.pot -= amount
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




end
