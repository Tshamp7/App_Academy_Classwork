class MaxIntSet
  attr_reader :max, :store
  def initialize(max)
    @max = max
    @store = Array.new(max, false)
  end

  def insert(num)
    validate!(num)
    @store[num] = true unless include?(num)
  end

  def remove(num)
    @store[num] = false if include?(num)
  end

  def include?(num)
    if @store[num] == true
      true
    else
      false
    end
  end

  private

  def is_valid?(num)
    num.between?(0, @max)
  end

  def validate!(num)
    raise 'Out of bounds' unless is_valid?(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    bucket = num % 20
    @store[bucket] << num unless include?(num)
    true
  end

  def remove(num)
    bucket = num % 20
    if @store[bucket].include?(num)
      @store[bucket].delete(num)
    end
  end

  def include?(num)
    bucket = num % 20
    @store[bucket].include?(num)
  end

end

class ResizingIntSet
  attr_reader :count
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    bucket = num % num_buckets
     unless include?(num)
      @store[bucket] << num 
      @count += 1
     end
     resize! if num_buckets < @count
  end

  def remove(num)
    bucket = num % num_buckets
    if include?(num)
      @store[bucket].delete(num)
      @count -= 1
    end
  end

  def include?(num)
    bucket = num % num_buckets
    @store[bucket].include?(num)
  end

  private

  def [](num)
    bucket = num % num_buckets
    @store[bucket]
  end

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store
    @store = Array.new(num_buckets * 2) { Array.new }
    @count = 0
    old_store.flatten.map { |num| insert(num) }
  end
end
