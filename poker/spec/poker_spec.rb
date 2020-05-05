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

    it 'should return an array of all cards values in that hand' do
      hand.cards = [card1, card2, card3, card6, card7]
      expect(hand.find_values).to eq(%w[3 3 3 9 5])
    end
  end

  describe '#find_suits' do
    it 'should return an array' do
      hand.cards = [card1, card2, card3, card6, card7]
      expect(hand.find_suits).to be_an(Array)
    end

    it 'should return an array of all cards suits in that hand' do
      hand.cards = [card1, card2, card3, card6, card7]
      expect(hand.find_suits).to eq(%w[clubs spades hearts hearts spades])
    end
  end
  
  describe '#cards_info' do
    it 'should return an array of the face values and suits of each card in the hand.' do
      hand.cards = [card1, card2, card3, card6, card7]
      expect(hand.cards_info).to eq(['3 of clubs',
                                     '3 of spades',
                                     '3 of hearts',
                                     '9 of hearts',
                                     '5 of spades'])
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

describe 'Player' do
  let(:player) { Player.new("Tom") }
  describe '#initialize' do
    it 'sets the players name equal to the name provided to the function.' do
      expect(player.name).to eq("Tom")
    end

    it 'should initialize an instance of Hand for the players hand.' do
      expect(player.hand).to be_a(Hand)
    end

    it 'should set the players pot to 500' do
      expect(player.pot).to eq(500)
    end
  end

  describe '#discard' do
    it 'raises an error when the player does not provide a valid index position.' do
      expect { player.discard(-1) }.to raise_error('Your entry contains invalid index positions. Please use valid index positions.')
    end

    it 'removes the cards stored at the passed in index positions from the players hand.' do
      player.hand = [0, 1, 2, 3, 4]
      player.discard(0)
      expect(player.hand).to eq([nil, 1, 2, 3, 4])
    end
  end

end

describe 'Game' do
  let(:game) { Game.new("Tom", "Amber", "Kai", "Joe")}

  describe '#initialize' do
    it 'should create an array to hold players names.' do
      expect(game.players).to be_an(Array)
    end

    it 'The players array should be populated with player instances.' do
      expect(game.players[0]).to be_a(Player)
    end
  end

  describe '#change_turn' do
    it 'should change the current player turn to the next player in the players array.' do
      curr_player = game.turn.name
      game.change_turn
      new_curr_player = game.turn.name
      expect(curr_player).not_to eq(new_curr_player)
    end
  end

  describe '#display_pot' do
    it 'should display the amount in the pot.' do
      expect(game.display_pot).to eq(0)
    end
  end

  describe '#deal' do
    it 'should deal 5 cards into the players hand.' do
      game.deck.build_deck
      game.deck.shuffle
      game.deal
      current_players_cards = game.turn.hand.cards
      expect(current_players_cards.length).to eq(5)
    end
  end

  describe '#find_best_hand' do
    it 'should find the best hand out of all the players hands.' do
      game.deck.build_deck
      game.deck.shuffle
      game.deal
      expect(game.find_best_hand).to be_a(Player)
      game.find_best_hand
    end
  end

  describe '#fold' do
    it 'should remove the player who folded from the players array.' do
      game.fold
      expect(game.players.length).not_to eq(4)
    end
  end

  describe '#assign_winnings' do
    it 'should increase the winning players individual pot by the table pot amouunt.' do
      game.deck.build_deck
      game.deck.shuffle
      game.deal
      game.pot = 2000
      game.high_bet_placer = game.find_best_hand
      game.assign_winnings
      expect(game.find_best_hand.pot).to eq(2500)
    end
  end

  describe '#empty_hands' do
    it 'should empty all players hands' do
      game.deck.build_deck
      game.deck.shuffle
      game.deal
      game.empty_hands
      expect(game.turn.hand.cards).to be_empty
    end
  end

  describe '#buy_in' do
    it 'should buy in all players and subtract the buy in amount from each players pot.' do
      game.buy_in
      expect(game.turn.pot).to eq(450)
    end

    it 'should add the amounts subtracted from each players pot to the tables pot.' do
      game.buy_in
      expect(game.pot).to eq(game.buy_in_amount * game.players.size)
    end
  end

end
