class HashSet
  attr_reader :count, :store
  attr_writer :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    return false if include?(key)

    self[key.hash] << key
    self.count += 1
    resize! if self.count >= num_buckets
  end

  def include?(key)
    self[key.hash].include?(key)
  end

  def remove(key)
    return nil unless include?(key)
    self[key.hash].delete(key)
    self.count -= 1
  end

  private

  def [](num)
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    old_store = self.store
    @store = Array.new(num_buckets * 2) { Array.new }
    @count = 0
    old_store.flatten.map { |num| insert(num) } # turns the old store into a 1D array. Then, by mapping, it calls insert on each item, distributing it into the new store. 
  end
end
