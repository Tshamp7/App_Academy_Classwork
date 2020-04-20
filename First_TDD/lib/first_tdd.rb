require 'rspec'

  def my_uniq(array)
    output = []
    array.each do |item|
      output << item unless output.include?(item)
    end
    output
  end

  def two_sum(array)
    output = []
    array.each_with_index do |item, idx|
      array.each_with_index do |item2, idx2|
        pos_arr = [idx, idx2]
        sorted_arr = pos_arr.sort
        if (item + item2 == 0) && !output.include?(sorted_arr)
          output << sorted_arr
        end
      end
    end
    output.sort
  end

  def my_transpose!(array)
    (0...array.length).each do |i|
      0.upto(i) do |j|
        array[i][j], array[j][i] = array[j][i], array[i][j]
      end
    end
    array
  end


  prices = [0.81, 0.95, 1.47, 1.00, 3.10, 1.75, 2.84, 1.17, 2.20]

  def stock_picker(array)
    output = {}
    array.each_with_index do |price, idx|
      array.each_with_index do |price2, idx2|
        if idx2 > idx && price2 > price
          price_dif = price2 - price
          output[price_dif] = [idx, idx2]
        end
      end
    end
    greatest_price = output.keys
    sorted_prices = greatest_price.sort
    output.values_at(sorted_prices[-1]).flatten
  end

class Towers_of_Hanoi
  attr_accessor :arrays, :game_over
  def initialize
    @arrays = [[3, 2, 1], [], []]
    @game_over = false
  end

  def move (start_pos, end_pos)
    if arrays[start_pos].empty?
      raise 'cannot move from an empty stack'
    end

    if !arrays[end_pos].empty? 
      if arrays[end_pos].last < arrays[start_pos].last
        raise 'cannot move onto a smaller disk'
      end
    end


    arrays[end_pos] << arrays[start_pos].pop
  end

  def get_input
    puts 'Please enter the tower position you would like to move from as a single number.'
      start_pos = gets.chomp.to_i
    puts 'Please enter the tower position you would like to move to as a single number.'
      end_pos = gets.chomp.to_i
      move(start_pos, end_pos)
  end

  def play_game
    until game_over
      render
      get_input
      won?
      system("clear")
    end
  end

  def won?
    if arrays[0].empty? && (arrays[1].empty? || arrays[2].empty?)
      system("clear")
      render
      puts "Congratulations! You won the game!"
      sleep(2)
      @game_over = true
      return true
    end
    @game_over = false
  end

  def render
    p "Tower1: #{arrays[0]} Tower2: #{arrays[1]} Tower3: #{arrays[2]}"
  end

end




