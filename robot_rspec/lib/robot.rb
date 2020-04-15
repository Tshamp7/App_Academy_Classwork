class Robot
  attr_reader :items, :position
  attr_writer :items, :position
  def initialize
      @position = [0, 0]
  end

  def move_left
    vertical = 0
    horizontal = -1
    @position = [position[0] += vertical, position[1] += horizontal]
  end

  def move_right
    vertical = 0
    horizontal = 1
    @position = [position[0] += vertical, position[1] += horizontal]
  end

  def move_up
    vertical = -1
    horizontal = 0
    @position = [position[0] += vertical, position[1] += horizontal]
  end

  def move_down
    vertical = 1
    horizontal = 0
    @position = [position[0] += vertical, position[1] += horizontal]
  end

  def items
    @items = []
  end

  def pick_up(item)
    self.items << item
  end

end

class Item
  attr_accessor :name, :weight
  def initialize(name, weight)
    @name = name
    @weight = weight
  end

end