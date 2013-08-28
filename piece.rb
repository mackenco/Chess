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
    self.row, self.col = target_r, target_c
  end


  def make_move(target_r, target_c, cm_check = false)
    if get_valid_moves.include?([target_r, target_c])
      unless check_move(target_r, target_c)
        return true if cm_check
        self.move(target_r, target_c)
      else
        return false if cm_check
        raise "That would put you in check."
      end

    else
      raise "That move's not possible!"
    end
  end

  def check_move(target_r, target_c)
    start_r, start_c = row, col
    piece = board[target_r, target_c]

    self.move(target_r, target_c)
    makes_check = board.king_in_check?(color)
    self.move(start_r, start_c)

    board[target_r, target_c] = piece

    makes_check
  end
end