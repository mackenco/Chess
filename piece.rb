class Piece
  attr_accessor :color, :row, :col, :board, :label

  def initialize(color, row, col, board, label)
    @color = color
    @row = row
    @col = col
    @board = board
    @label = label
  end

  def move_horizontal(dir)
    @board[row, col + dir] = self
    @board[row, col] = nil
    self.col += dir
  end

  def move_vertical(dir)
    @board[row + dir, col] = self
    @board[row, col] = nil
    self.row += dir
  end

  def move_diagonal(dir_h, dir_v)
    @board[row + dir_v, col + dir_h] = self
    @board[row, col] = nil
    self.row += dir_v
    self.col += dir_h
  end

end


class Rook < Piece

  def initialize(color, row, col, board)
    color == :black ? label = :R : label = :r
    super(color, row, col, board, label)
  end

end