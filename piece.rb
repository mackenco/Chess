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
      unless check_move(target_r, target_c)
        self.move(target_r, target_c)
      else
        raise "That would put you in check."
      end
    else
      raise "That move's not possible!"
    end
  end

  def check_move(target_r, target_c)
    #checks if your king would be in check after your move
    start_r = row
    start_c = col

    self.move(target_r, target_c)
    makes_check = board.king_in_check?(color)
    self.move(start_r, start_c)

    makes_check
  end

  def deep_dup(arr)
      arr.map{|sub| sub.dup}
  end
end