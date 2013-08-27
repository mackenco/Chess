class Piece
  attr_accessor :color, :row, :col, :board, :label, :unicode

  def initialize(color, row, col, board, label, unicode)
    @color = color
    @row = row
    @col = col
    @board = board
    @label = label
  end

  def move_horizontal(dir, board)
    board[row, col + dir] = self
    board[row, col] = nil
    self.col += dir
  end

  def move_vertical(dir, board)
    board[row + dir, col] = self
    board[row, col] = nil
    self.row += dir
  end

  def move_diagonal(dir_h, dir_v, board)
    board[row + dir_v, col + dir_h] = self
    board[row, col] = nil
    self.row += dir_v
    self.col += dir_h
  end

  def deep_dup(arr)
    temp_array=[]
    arr.each{|sub| temp_array << sub.dup}
    temp_array
  end

  def verify_move?(row, col, target_r, target_c)
    return true if board[row, col].nil?
    if row == target_r && col == target_c && board[row, col].color != color
      return true
    end
    false
  end
end