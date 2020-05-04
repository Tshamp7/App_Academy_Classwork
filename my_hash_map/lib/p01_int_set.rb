class MaxIntSet
  attr_reader :max, :store
  def initialize(max)
    @max = max
    @store = Array.new(max, false)
  end

  def include?(num)
    return true if self.store[num] == true
    return false
  end

  def insert(num)
    raise "Out of bounds" unless num.between?(0, @max)
    if self.store[num] == false && num.between?(0, @max)
      self.store[num] = true
      true
    else
      false
    end
  end

  def remove(num)
    if self.include?(num)
      self.store[num] = false
    else
      p "set does not contain #{num}"
    end
  end
 
end


class IntSet
  attr_reader :store
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def include?(num)
    bucket = num % num_buckets

    if self.store[bucket].include?(num)
      true
    else
      false
    end
  end

  def insert(num)
    bucket = num % num_buckets

    self.store[bucket] << num unless self.include?(num)
  end

  def remove(num)
    bucket = num % num_buckets
    if self.include?(num)
      store[bucket].delete(num)
      true
    else
      false
    end
  end


  private

  def num_buckets
    self.store.length
  end
  

end

class ResizingIntSet
  attr_reader :count, :store
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def include?(num)
    self[num].include?(num)
  end

  def insert(num)
    return false if include?(num)
    self[num] << num
    @count += 1
    resize! if @count >= num_buckets
  end

  def remove(num)
    if include?(num)
      self[num].delete(num)
      @count -= 1
    end
  end

  private

  def [](num)
    bucket = num % num_buckets
    self.store[bucket]
  end

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store
    @count = 0
    @store = Array.new(num_buckets * 2) { Array.new }
    old_store.flatten.each { |num| insert(num) }
  end
end
