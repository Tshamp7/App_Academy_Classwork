class Robot
  attr_accessor :items, :position, :items_weight, :health, :equipped_weapon
  def initialize
    @position = [0, 0]
    @items = []
    @items_weight = 0
    @health = 100
    @equipped_weapon = nil
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

  class HeavyItemError < ArgumentError
    def message
        puts "Thats too heavy for me to pickup!"
    end
  end


  def pick_up(item)
      if items_weight + item.weight <= 250
        @items << item
      else
        raise ArgumentError
      end
  end

  def items_weight
    if @items.empty?
      return @items_weight = 0
    else
      return @items_weight = @items.map(&:weight).sum
    end
  end

  def wound(amount)
    if (health - amount).negative? 
      @health = 0
    else
      @health = health - amount
    end
  end

  def heal(amount)
    if (health + amount) > 100 
      @health = 100
    else
      @health = health + amount
    end
  end

  def attack(robot)
    if equipped_weapon.nil?
      robot.wound(5)
    else
      equipped_weapon.hit(robot)
    end
  end
end

class Item
  attr_accessor :name, :weight
  def initialize(name, weight = 0)
    @name = name
    @weight = weight
  end
end

class Bolts < Item
  attr_accessor :bolts, :name, :weight
  def initialize
    @name = 'bolts'
    @weight = 25
  end

  def feed(robot)
    robot.heal(weight)
  end
end

class Weapon < Item
    attr_accessor :name, :weight, :damage
    def initialize(name, weight, damage)
        @name = name
        @weight = weight
        @damage = damage
    end

    def hit(robot)
        robot.wound(damage)
    end
end

class Laser < Weapon
  def initialize
    @name = 'laser'
    @weight = 125
    @damage = 25
  end
end

class PlasmaCannon < Weapon
  def initialize
    @name = 'plasma cannon'
    @weight = 200
    @damage = 55
  end
end