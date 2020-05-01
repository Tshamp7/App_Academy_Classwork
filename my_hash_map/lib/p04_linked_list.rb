class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    @prev.next = self.next
    @next.prev = self.prev
  end
end

class LinkedList
  include Enumerable
  attr_reader :head, :tail
  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    head.next
  end

  def last
    tail.prev
  end

  def empty?
    self.head.next == self.tail
  end

  def get(key)
    each do |node|
      if node.key == key
        return node.val
      end
    end
    nil
  end

  def include?(key)
    each do |node|
      if node.key == key
        return true
      end
    end
    false
  end

  def append(key, val)
    new_node = Node.new(key, val)

    self.tail.prev.next = new_node
    new_node.prev = self.tail.prev
    new_node.next = self.tail
    self.tail.prev = new_node
    new_node
  end

  def update(key, val)
    each do |node|
      if node.key == key
       node.val = val
      end
    end
  end

  def remove(key)
    each do |node|
      node.remove if node.key == key
    end
  end

  def each
    current_node = first
    until current_node == tail
      yield current_node
      current_node = current_node.next
    end
  end

  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
