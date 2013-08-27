class Piece
  attr_accessor :color, :row, :col, :board, :label

  def initialize(color, row, col, board, label)
    @color = color
    @row = row
    @col = col
    @board = board
    @label = label
  end

  def move(new_row, new_col)
    if actual_move?(new_row, new_col) && move_valid?(new_row, new_col)
      @board[new_row, new_col] = self
      @board[row, col] = nil
      self.row = new_row
      self.col = new_col
    end
  end

  def actual_move?(new_row, new_col)
     new_row != row || new_col != col
  end


end


class Rook < Piece

  def initialize(color, row, col, board)
    color == :black ? label = :R : label = :r
    super(color, row, col, board, label)
  end

  def move_valid?(new_row, new_col)
    if new_row == @row
      return true
    elsif new_col == @col
      return true
    end
    false
  end

end