class Piece
  attr_accessor :color, :row, :col, :board, :unicode

  def initialize(color, row, col, board, unicode)
    @color = color
    @row = row
    @col = col
    @board = board
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

  def verify_move?(cur_row, cur_col, target_r, target_c)
    out = false
    return true if board[cur_row, cur_col].nil?
    if cur_row == target_r && cur_col == target_c && board[cur_row, cur_col].color != color
      out = true
    end
    out
  end
end