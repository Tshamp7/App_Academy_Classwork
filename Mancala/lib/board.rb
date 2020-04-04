 require 'byebug'
 class Board
   attr_accessor :cups
   attr_reader :player1, :player2
   def initialize(name1, name2)
     @player1 = name1
     @player2 = name2
     @cups = Array.new(14) { Array.new }
     self.place_stones
   end
   def place_stones
     @cups.each_with_index do |cup, idx|
       if idx != 6 && idx != 13
         (0..3).each { |i| cup << :stone }
       end
     end
   end
   def valid_move?(start_pos)
     raise "Invalid starting cup" if start_pos < 0 || start_pos > 12
     raise "Starting cup is empty" if @cups[start_pos].empty?
   end
   def make_move(start_pos, current_player_name)
     stones = @cups[start_pos]
     cup_idx = start_pos
     @cups[start_pos] = []
     player_1_points_cup = 6
     player_2_points_cup = 13

     until stones.empty?
       cup_idx += 1
        cup_idx = 0 if cup_idx > 13
       if cup_idx == player_1_points_cup
         @cups[cup_idx] << stones.pop if current_player_name == self.player1
       elsif cup_idx == player_2_points_cup
         @cups[cup_idx] << stones.pop if current_player_name == self.player2
       else
         @cups[cup_idx] << stones.pop
       end
     end
     render
     next_turn(cup_idx)
   end


   def next_turn(ending_cup_idx)

    if ending_cup_idx == 6 || ending_cup_idx == 13
      :prompt
    elsif @cups[ending_cup_idx].length == 1
      :switch
    else
       ending_cup_idx
    end

   end


   def render
     print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
     puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
     print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
     puts ""
     puts ""
   end


   def one_side_empty?
    player1_side = (0..5)
    player2_side = (6..12)

    return true if (player1_side.all? { |i| @cups[i].empty? }) || (player2_side.all? { |i| @cups[i].empty? })
    return false
   end


   def winner
    player_1_points_cup = 6
    player_2_points_cup = 13

    return :draw if @cups[player_1_points_cup] == @cups[player_2_points_cup]

    @cups[player_1_points_cup].length > @cups[player_2_points_cup].length ? @player1 : @player2

   end
 end


