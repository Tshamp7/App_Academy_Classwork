# PHASE 2
def convert_to_int(str)
  num = Integer(str)
rescue ArgumentError
  puts "Please enter a numeric string"
ensure
  num ||= 0
end

# PHASE 3

class CoffeeError < StandardError
  def message
    "I cant have anymore coffee! I've had too much caffeine today! (^O,..,O^) "
  end
end


class NotAFruitError < StandardError
  def message
    puts "That doesn't look like a fruit! I can only have fruits and coffee! (^X,..,x^) "
  end
end



FRUITS = ["apple", "banana", "orange"]

def reaction(maybe_fruit)
  if FRUITS.include? maybe_fruit
    puts "OMG, thanks so much for the #{maybe_fruit}!"
  elsif maybe_fruit == "coffee"
    raise CoffeeError
  else
    raise NotAFruitError
  end 
end

def feed_me_a_fruit
  puts "Hello, I am a friendly monster. (^o,..,o^) "

  puts "Feed me a fruit! (Enter the name of a fruit:)"
  begin

    maybe_fruit = gets.chomp
    reaction(maybe_fruit) 
  rescue CoffeeError => e
    puts e.message
  retry
  rescue NotAFruitError => e
    puts e.message
  end
end

# PHASE 4
class BestFriend
  def initialize(name, yrs_known, fav_pastime)
    raise ArgumentError.new("Name cannot be blank") if name.empty?
    raise ArgumentError.new("Yrs known must be greater than or equal to 5") if yrs_known.to_i < 5
    raise ArgumentError.new("Favorite pastime cannot be blank") if fav_pastime.empty?

    @name = name
    @yrs_known = yrs_known
    @fav_pastime = fav_pastime
  end

  def talk_about_friendship
    puts "Wowza, we've been friends for #{@yrs_known}. Let's be friends for another #{1000 * @yrs_known}."
  end

  def do_friendstuff
    puts "Hey bestie, let's go #{@fav_pastime}. Wait, why don't you choose. 😄"
  end

  def give_friendship_bracelet
    puts "Hey bestie, I made you a friendship bracelet. It says my name, #{@name}, so you never forget me." 
  end
end




