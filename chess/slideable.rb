require 'byebug'

module Slideable
  HORIZONTAL_AND_VERTICAL_DIRS = [
    [-1, 0],
    [0, -1],
    [0, 1],
    [1, 0]
  ].freeze  
  DIAGONAL_DIRS = [
    [-1, -1],
    [-1, 1],
    [1, -1],
    [1, 1]
  ].freeze  

  def horizontal_and_vertical_dirs
    HORIZONTAL_AND_VERTICAL_DIRS
  end  

  def diagonal_dirs
    DIAGONAL_DIRS
  end  

  def moves
    moves = []  
    move_dirs.each do |dx, dy|
      moves.concat(grow_unblocked_moves_in_dir(dx, dy))
    end  
    moves
  end

  def move_dirs
    # subclass implements this
    raise NotImplementedError
  end

    private

  def grow_unblocked_moves_in_dir(dx, dy)
    cur_x = pos[0]
    cur_y = pos[1]
    moves = []
    while board.valid_pos?(pos)
      cur_x += dx
      cur_y += dy        
      pos = [cur_x, cur_y]
      break unless board.valid_pos?(pos)

      if board.is_empty?(pos) #empty space is a valid move. 
        moves << pos
      else
        moves << pos if board.board[pos[0]][pos[1]].color != color #can replace, or "take" opponents piece if the color is not the same as color of self. 
        break
      end
    end
    moves
  end

  end