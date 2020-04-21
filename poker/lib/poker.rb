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
        deck << card
      end
    end
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

  def winning_hand?(other_hand)
    other_hand.calculate_hand
    calculate_hand
    if hand_rankings.index(type) < hand_rankings.index(other_hand.type)
      @winning_hand = true
      true
    end
  end
end

