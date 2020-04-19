require 'rspec'
require 'first_tdd'


describe '#my_uniq' do
let(:array) { [1, 3, 4, 1, 3, 7] }
let(:uniqued_array) { my_uniq(array.dup) }

  it "removes duplicates" do
    array.each do |item|
      expect(uniqued_array.count(item)).to eq(1)
    end 
  end
  
  it "does not modify the original array" do
    expect { my_uniq(array) }.to_not change{array}
  end
  
  it "only contains items from the original array" do
    uniqued_array.each do |item|
        expect(array).to include(item)
      end
  end
end

describe '#two_sum' do
  let(:array) { [-5, -3, 1, 3] }
  
  
  it 'should not modify the original array' do
    orig_arr = array.dup.map(&:dup)
    two_sum(array)
    expect(array).to eq(orig_arr)
  end

  it 'should return the positions of a pair that sum to zero' do
      expect(two_sum(array)).to eq([[1, 3]])
  end
end

describe '#my_transpose!' do
  let(:grid) {[[0, 1, 2],
               [3, 4, 5],
               [6, 7, 8]]}

  let(:trans_grid) {[[0, 3, 6],
                     [1, 4, 7],
                     [2, 5, 8]]}

  it 'should transpose the array' do
    expect(my_transpose!(grid)).to eq(trans_grid)
    end
end

describe '#stock_picker' do
  let(:stocks) { [0.81, 0.95, 1.47, 1.00, 3.10, 1.75, 2.84, 1.17, 2.20] }
  
  it 'should return the days on which it would have been best to buy, and then sell the stock.' do
    expect(stock_picker(stocks)).to eq([0, 4])
  end
end

describe 'Towers_of_Hanoi' do
  let(:towers) { Towers_of_Hanoi.new }

    describe '#initialize' do
      it 'should initialize three arrays' do
        expect(towers.arrays.size).to eq(3)
      end
    end

  describe '#render' do
    it 'should print the contents of the towers' do
      expect(towers.render).to eq("Tower1: [3, 2, 1] Tower2: [] Tower3: []")
    end
  end
  
    describe '#move' do
      it 'should allow the user to move to a blank space' do
       expect { towers.move(0, 1)}.not_to raise_error
      end

      it 'should allow the user to move onto a larger disk.' do
        towers.move(0, 2)
        towers.move(0, 1)
        expect { towers.move(2, 1) }.not_to raise_error
      end

      it 'does not allow movement from an empty stack.' do
        expect { towers.move(1, 2) }
        .to raise_error('cannot move from an empty stack')
      end

      it 'does not allow moving onto a smaller disk' do
        towers.move(0, 1)
        expect { towers.move(0, 1) }
        .to raise_error('cannot move onto a smaller disk')
      end
  end

  describe '#won?' do
    it 'is not won at the beginning' do
      expect(towers).not_to be_won
    end

    it "is won when all disks are moved to tower 1" do
      # Perform the moves to move the game into winning position
      towers.move(0, 1)
      towers.move(0, 2)
      towers.move(1, 2)
      towers.move(0, 1)
      towers.move(2, 0)
      towers.move(2, 1)
      towers.move(0, 1)

      expect(towers).to be_won
    end

    it "is won when all disks are moved to tower 2" do
      # Perform the moves to move the game into winning position
      towers.move(0, 2)
      towers.move(0, 1)
      towers.move(2, 1)
      towers.move(0, 2)
      towers.move(1, 0)
      towers.move(1, 2)
      towers.move(0, 2)

      expect(towers).to be_won
    end
  end


end

