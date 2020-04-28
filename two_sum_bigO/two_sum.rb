require 'byebug'

nums = [0, 1, 5, 7]

#the time complexity of this is O(n^2)
def bad_two_sum?(arr, target)
  arr.each_with_index do |num, i|
    arr.each_with_index do |num2, j|
        next if i == j
        return true if num + num2 == target
    end
  end
  false
end

#p bad_two_sum?(nums, 6) > true
#p bad_two_sum?(nums, 10) > false


def okay_two_sum?(arr, target)
  sorted = arr.sort
  sorted.each_with_index do |el, i|
   match_index = sorted.bsearch_index { |x| (target - el) == x }
   return true if match_index && match_index != i
  end
  false
end

#p okay_two_sum?(nums, 6)

def best_two_sum?(arr, target_sum)
    nums_hash = {}
  
    arr.each do |el|
      return true if nums_hash[target_sum - el]
      nums_hash[el] = true
    end
  
    false
  end


#p best_two_sum?(nums, 6)