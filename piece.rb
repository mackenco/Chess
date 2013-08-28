class Piece
  attr_accessor :color, :row, :col, :board, :unicode

  def initialize(color, row, col, board, unicode)
    @color = color
    @row = row
    @col = col
    @board = board
  end

  def move(target_r, target_c)
    board[target_r, target_c] = self
    board[row, col] = nil
    self.row = target_r
    self.col = target_c
  end

  def make_move(target_r, target_c)
    if get_valid_moves.include?([target_r, target_c])
      self.move(target_r, target_c)
    else
      raise "That move's not possible!"
    end
  end
end