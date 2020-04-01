class Queue_thing #objects can only enter or leave the queue on a FIFO basis.
    def initialize
        @queue = []
    end

    def enqueue(el)
        @queue << el
    end

    def dequeue
        @queue.shift
    end

    def peek
        return @queue[0]
    end
  end