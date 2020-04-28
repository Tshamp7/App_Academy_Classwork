
#O(n^3) due to use of rubys built-in min and max methods on each iterations. 
#These are both O(n). The third O(n) comes from slicing the array into a new array at each iteration.
def windowed_max_range(arr, rng)
  current_max_range = 0

  (0...arr.length).each do |i|
    starting_index = i
    ending_index = i + (rng - 1)

    new_arr = arr[starting_index..ending_index]
    current_min = new_arr.min

    current_max = new_arr.max
    new_max_range = current_max - current_min
    current_max_range = new_max_range if new_max_range > current_max_range
  end
  current_max_range
end

# p windowed_max_range([1, 0, 2, 5, 4, 8], 2)  #4 from 4, 8
# p windowed_max_range([1, 0, 2, 5, 4, 8], 3)  #5 from 0, 2, 5
# p windowed_max_range([1, 0, 2, 5, 4, 8], 4)  #6 from 2, 5, 4, 8
# p windowed_max_range([1, 3, 2, 5, 4, 8], 5)  #6 from 3, 2, 5, 4, 8

#In order to improve this method I will implement some stack and queue classes. These will be
#MyQueue, MyStack, StackQueue, MinMaxStack, and MinMaxStackQueue.

#This class will create a queue, which operates on FIFO order.
class MyQueue
  attr_writer :store
  def initialize
    @store = []
  end

  def peek
    @store.first
  end

  def size
    @store.size
  end

  def empty?
    @store.empty?
  end

  def enqueue(num)
    @store << num
  end

  def dequeue(num)
    @store.shift
  end
end

# queue1 = MyQueue.new

# p queue1
# queue1.enqueue(0)
# p queue1.store

#This class will implement a stack, which operates on FILO order.

class MyStack
  attr_reader :store
  def initialize
    @store = []
  end

  def peek
    @store.last
  end

  def empty?
    @store.empty?
  end

  def size
    @store.size
  end

  def pop(num)
    @store.pop(num)
  end

  def push(num)
    @store.push(num)
  end
end

class StackQueue
  attr_reader :instack, :outstack
  def initialize
    @instack = MyStack.new
    @outstack = MyStack.new
  end

  def size
    @instack.size + @outstack.size
  end

  def empty?
    @instack.empty? && @outstack.empty?
  end

  def enqueue(num)
    @instack << num
  end

  def dequeue(num)
    queueify if out_stack.empty?
    @outstack.pop
  end

  private
  def queueify
    # How do you turn a stack into a queue? Flip it upside down.
    @out_stack.push(@in_stack.pop) until @in_stack.empty?
  end
end

class MinMaxStack
  attr_reader :store
  def initialize
    @store = MyStack.new
  end

  def peek
    @store.peek[:value] unless empty?
  end

  def size
    @store.size
  end

  def empty?
    @store.empty?
  end

  def max
    @store.peek[:max] unless empty?
  end

  def min
    @store.peek[:min] unless empty?
  end

  def pop
    @store.pop[:value]
  end
 #whenever an item is pushed to the store, the max and min at that point in time are evaluated,
 #and the min, max and current value being passed are pushed to the store together as a hash. 
  def push(val)
    @store.push({
      max: new_max(val),
      min: new_min(val),
      value: val
    })
  end

  private

  def new_max(val)
    if empty?
      val
    else
      [max, val].max
    end
  end

  def new_min(val)
    if empty?
      val
    else
      [min, val].min
    end
  end
end

class MinMaxStackQueue
  def initialize
    @in_stack = MinMaxStack.new
    @out_stack = MinMaxStack.new_arr
  end

  def size
    @in_stack.size + @out_stack.size
  end

  def empty?
    @in_stack.empty? && @out_stack.empty?
  end

  def dequeue
    queueify if @out_stack.empty?
    @out_stack.pop
  end

  def enqueue(val)
    @in_stack.push(val)
  end

  def max
    maxes = []
    maxes << @in_stack.max unless @in_stack.empty?
    maxes << @out_stack.max unless @out_stack.empty?
    maxes.max
  end


  def min
    mins = []
    mins << @in_stack.min unless @in_stack.empty?
    mins << @out_stack.min unless @out_stack.empty?
    mins.min
  end

end




