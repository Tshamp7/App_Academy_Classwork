require 'poker.rb'

describe 'Card' do
  let(:card) {Card.new('3', 'clubs')}

  it 'should contain a string representing the face value of the card.' do
    expect(card.face_value).to be_a(String)
  end

  it 'has a suit' do
    expect(card.suit).not_to be(false)
  end
end


describe 'Deck' do
  let(:cards) { Deck.new }

  describe '#initialize' do
    it 'should initialize an array for the deck' do
      expect(cards.deck).to be_a(Array)
    end

    it 'The deck array should begin empty' do
      expect(cards.deck).to be_empty
    end

    it 'should have a suits variable containing the four suits.' do
      expect(cards.suits).to eq(%w[hearts clubs diamonds spades])
    end

    it 'should have a values array containing all 13 card types' do
      expect(cards.values).to eq(%w[A 2 3 4 5 6 7 8 9 10 J Q K])
    end
  end

  describe '#build_deck' do
    it 'should populate the deck with 52 card.' do
      cards.build_deck
      expect(cards.deck.length).to eq(52)
    end
  end
end

describe 'Hand' do

  let(:hand) { Hand.new }
  let(:hand2) { Hand.new }
  let(:card1) { Card.new('clubs', '3')}
  let(:card2) { Card.new('spades', '3')}
  let(:card3) { Card.new('hearts', '3')}
  let(:card4) { Card.new('diamonds', '3')}
  let(:card5) { Card.new('clubs', 'K')}
  let(:card6) { Card.new('hearts', '9')}
  let(:card7) { Card.new('spades', '5')}

  describe '#initialize' do
    it 'Should initialize an array' do
      expect(hand.cards).to be_an(Array)
    end

    it 'The array should be empty' do
      expect(hand.cards).to be_empty
    end

    it 'Should set the type category to nil' do
      expect(hand.type).to be_nil
    end
  end

  describe '#calculate_hand' do
  
    it 'should identify a pair' do 
      hand.cards = [card1, card2, card5, card6, card7]
      hand.calculate_hand
      expect(hand.type).to eq('pair')
    end

    it 'should identify three-of-a-kind' do
      hand.cards = [card1, card2, card3, card6, card7]
      hand.calculate_hand
      expect(hand.type).to eq('three-of-a-kind')
    end

    it 'should identify four-of-a-kind' do
      hand.cards = [card1, card2, card3, card4, card5]
      hand.calculate_hand
      expect(hand.type).to eq('four-of-a-kind')
    end
  end

  describe '#find_values' do
    it 'should return an array' do
      hand.cards = [card1, card2, card3, card6, card7]
      expect(hand.find_values).to be_an(Array)
    end

    it 'should return an array of all cards face_values in that hand' do
      hand.cards = [card1, card2, card3, card6, card7]
      expect(hand.find_values).to eq(%w[3 3 3 9 5])
    end
  end

  describe '#find_suits' do
    it 'should return an array' do
      hand.cards = [card1, card2, card3, card6, card7]
      expect(hand.find_suits).to be_an(Array)
    end

    it 'should return an array of all cards face_values in that hand' do
      hand.cards = [card1, card2, card3, card6, card7]
      expect(hand.find_suits).to eq(%w[clubs spades hearts hearts spades])
    end
  end

  describe '#winning_hand?' do
    it 'should return true if it beats a hand it is compared against.' do
      hand.cards = [card1, card2, card3, card6, card7]
      hand.calculate_hand
      hand2.cards = [card1, card2, card5, card6, card7]
      hand2.calculate_hand
      expect(hand.winning_hand?(hand2)).to eq(true)
    end
  end




end