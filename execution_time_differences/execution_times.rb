require 'byebug'


list = [0, 3, 5, 4, -5, 10, 1, 90]

def find_small(arr)
 start = Time.now
  smallest = arr[0]

  arr.each do |num|
    smallest = num if num < smallest
  end
  smallest
  Time.now - start
end

def find_small_v2(arr)
    start = Time.now
    arr.each_with_index do |num, i|
        small_num = num
      arr.each_with_index do |another_num, j|
        next if i == j
        small_num = another_num if another_num < small_num
      end
     small_num
    end
    Time.now - start
end

# p find_small(list)
# p find_small_v2(list)

arr1 = [5, 3, -7]
arr2 = [2, 3, -6, 7, -6, 7]


# this method is very complex and i believe has a big O notation of O(n^3) as it has to iterate through the array three times. 
def sub_array_sums(arr)
  sub_arrays = []
    arr.each_index do |i|
      (i...arr.length).each do |j|
          sub_arrays << arr[i..j]
      end
    end

  greatest_sum = sub_arrays[0].sum

  sub_arrays.each do |sub_array|
    sum = sub_array.sum
    greatest_sum = sum if sum > greatest_sum
  end
  greatest_sum
end

#this method is much simpler as it only has to pass through the array one time to find the largest sub-array sum. 
def largest_contig_sum(arr)
  current = arr[0]
  largest = arr[0]

  (1...arr.length).each do |i|
    current = 0 if current < 1
    current += arr[i]
    largest = current if current > largest
  end
  largest
end

p largest_contig_sum(arr2)



