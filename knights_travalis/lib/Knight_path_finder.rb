require_relative "00_tree_node.rb"
require "byebug"

class KnightPathFinder
    attr_accessor :start_pos, :considered_positions, :root_node
    def initialize(pos)
        @start_pos = pos
        @considered_positions = [pos]
        @root_node = PolyTreeNode.new(@start_pos)



        build_move_tree
    end

    MOVES = 
    [
        [-2, -1],
        [-2,  1],
        [-1, -2],
        [-1,  2],
        [ 1, -2],
        [ 1,  2],
        [ 2, -1],
        [ 2,  1]
    ]

    def valid_moves(pos) #build list of all valid moves.... moves are valid if they fall in valid coordinates on a 8x8 standard chess board using indexes of 0-7 X and 0-7 Y.
        valid_moves = []

        x = pos[0]
        y = pos[1]

        MOVES.each do |move|
            new_move = [x + move[0], y + move[1]]

            valid_moves << new_move if new_move.all? { |coord| coord.between?(0, 7) }
        end

        valid_moves
    end

    def new_move_positions(pos) 
        moves = valid_moves(pos)
        moves.reject! { |move| @considered_positions.include?(move) }
        moves.each do |move|
            @considered_positions << move
        end
        moves
    end

    def build_move_tree
        nodes = [@root_node]

        until nodes.empty?
            node = nodes.shift
            current_pos = node.value
            next_moves = new_move_positions(current_pos)
            next_moves.each do |next_move|
                child = PolyTreeNode.new(next_move)
                nodes << child
                node.add_child(child)
            end
        end
        
    end

    def find_path(end_pos)
        end_node = @root_node.dfs(end_pos)
        path = self.trace_path_back(end_node)
            return path.map(&:value).reverse
    end

    def trace_path_back(end_node)
        nodes = []
        current_node = end_node

        until current_node.nil?
            nodes << current_node
            current_node = current_node.parent
        end

        nodes
    end






end



arr = [0, 0]
knight = KnightPathFinder.new(arr)
p knight

arr2 = [7,7]
p knight.find_path(arr2)