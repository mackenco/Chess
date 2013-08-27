class Piece
  attr_accessor :color, :row, :col, :board

  def initialize(color, row, col, board)
    @color = color
    @row = row
    @col = col
    @board = board
  end

  def move(new_row, new_col)
    if actual_move?
    #check if valid
    #move it
  end

  def actual_move?(new_row, new_col)
     new_row != row && new_col != col
  end


end


class Rook < Piece
  def move_valid?(new_row, new_col)
    if new_row == @row
      [new_row...row].

    elsif new_col == @col
  end

end