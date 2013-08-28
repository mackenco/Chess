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


  def make_move(target_r, target_c, cm_check = false)
    if get_valid_moves.include?([target_r, target_c])
      unless check_move(target_r, target_c)
        if cm_check
          return true
        else
          self.move(target_r, target_c)
        end
      else
        unless cm_check
          raise "That would put you in check."
        else
          return false
        end
      end
    else
      raise "That move's not possible!"
    end
  end

  def check_move(target_r, target_c)
    start_r = row
    start_c = col

    self.move(target_r, target_c)
    makes_check = board.king_in_check?(color)
    self.move(start_r, start_c)

    makes_check
  end

  def deep_dup(arr) #delete?
      arr.map{|sub| sub.dup}
  end
end