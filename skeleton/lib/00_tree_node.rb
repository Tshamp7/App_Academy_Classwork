class PolyTreeNode
    attr_reader :value, :parent, :children
    attr_writer :parent, :children, :value
    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end

    def value
        @value
    end

    def parent
        @parent
    end

    def parent=(parent)
        if parent == nil
            return @parent = nil
        end

        if @parent != nil
            @parent.children.delete(self)
        end

        @parent = parent

        if !@parent.children.include?(self) && @parent != nil
            @parent.children << self 
        end
       
    end

    def children
        return @children
    end

    def add_child(child)
        @children << child if !@children.include?(child)
        child.parent = self
    end

    def remove_child(child)
        if !@children.include?(child)
            raise puts "That node is not a child."
        end
        @children.delete(child)
        child.parent = nil
    end

    def dfs(target)
        return nil if self.value == nil
        return self if self.value == target
    
        children.each do |child|
          result = child.dfs(target)
          return result unless result.nil?
        end
        nil
    end

    def bfs(target)
        nodes = [self]
        until nodes.empty?
            node = nodes.shift

            return node if node.value == target
            nodes.concat(node.children)
        end

        nil
    end












end