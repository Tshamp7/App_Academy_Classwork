fish_array = ['fish', 
              'fiiish', 
              'fiiiiish', 
              'fiiiish', 
              'fffish', 
              'ffiiiiisshh', 
              'fsh', 
              'fiiiissshhhhhh']


 #finds longest fish in quadratic O(n^2) time by comparing fish lengths from array against all other fish lengths from array. 
def quadratic_fish(arr)

  arr.each_with_index do |fish, i|
    longest_fish = true
    arr.each_with_index do |fish2, j|
      next if i == j
      longest_fish = false if fish2.length > fish.length
    end
    return fish if longest_fish
  end
end

p quadratic_fish(fish_array)


# return longest fish using ruby's built-in quicksort algorithm. 
def nlogn_fish(arr)
  arr.sort
  arr[-1]
end

p nlogn_fish(fish_array)

# return longest fish in O(n) time, passing through the array just one time. 

def on_fish(arr)
  longest_fish = arr[0]
    arr.each do |fish|
      longest_fish = fish if fish.length > longest_fish.length
    end
  longest_fish
end

p on_fish(fish_array)


tiles_array = ["up", "right-up", "right", "right-down", "down", "left-down", "left",  "left-up" ]


# returns index of desired direction in the array in O(n) time by searching throught he array once.
def slow_dance(direction, arr)
  arr.each_with_index do |dir, i|
    return i if dir == direction
  end
end

p slow_dance("up", tiles_array)

#returns index of desired direction by storing the indexes and directions in a hash and using quick look up property of hashes in ruby.

tiles_hash = {'up' => 0,
              'right-up' => 1,
              'right' => 2,
              'right-down' => 3,
              'down' => 4,
              'down-left' => 5,
              'left' => 6,
              'left-up' => 7}

def fast_dance(direction, hash)
  hash[direction]
end

p fast_dance('up', tiles_hash)
