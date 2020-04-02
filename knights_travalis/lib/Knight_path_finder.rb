require_relative "00_tree_node.rb"

class KnightPathFinder
    attr_reader :root_node
    def initialize(pos)
        @root_node = PolyTreeNode.new(pos)
        @move_tree = self.build_move_tree
    end

    MOVES = [
        [-2, -1],
        [-2,  1],
        [-1, -2],
        [-1,  2],
        [ 1, -2],
        [ 1,  2],
        [ 2, -1],
        [ 2,  1]
      ]
    def self.new_move_positions

    end    

    def valid_moves(pos)
        @considered positions = [pos]
    end
end