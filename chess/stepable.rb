module Stepable

KNIGHT = [
    [2, 1],
    [-2, -1],
    [-2, 1],
    [2, -1],
    [1, 2],
    [-1, -2],
    [-1, 2],
    [1, -2]
]

 KING = [
     [-1, 0],
     [-1, 1],
     [0, 1],
     [1, 1],
     [1, 0],
     [1, -1],
     [0, -1],
     [-1, -1]
 ]

 def move_type
    #implemented by piece subclass knight and king.
    raise NotImplementedError
 end

 def king_move_set
    KING
 end

 def knight_move_set
    KNIGHT
 end

 def moves
    moves = []
    move_type.each do |row, col|
        moves.concat(find_moves_of_piece_type(row, col))
    end
    moves
 end

 def find_moves_of_piece_type(row, col)

   cur_row = pos[0]
   cur_col = pos[1]
   moves = []

    while board.valid_pos?(pos)
      cur_row += row
      cur_col += col
      pos = [cur_row, cur_col]

      break unless board.valid_pos?(pos)

        if board.is_empty?(pos)
            moves << pos
            break #break here, as king can only move one space at a time. 
        else 
            moves << pos if self.color != color #break after taking an opponents piece. 
            break
        end
    end
    moves
 end

end