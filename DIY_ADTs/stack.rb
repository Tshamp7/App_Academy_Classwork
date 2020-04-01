class Stack #objects can only enter or leave the stack on a LIFO basis.
    def initialize
      @stack = []
    end

    def push(el)
      @stack.push(el)
    end

    def pop
      @stack.pop
    end

    def peek
        return @stack[-1]
    end
  end





  