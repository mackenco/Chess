class Piece
  attr_accessor :color, :row, :col, :board, :unicode, :moved

  def initialize(color, row, col, board, unicode)
    @color = color
    @row = row
    @col = col
    @board = board
    @moved = false
  end

  def move(target_r, target_c, check = false)
    board[target_r, target_c] = self
    board[row, col] = nil
    self.row, self.col = target_r, target_c
    self.pawn_promote unless check
  end


  def make_move(target_r, target_c, cm_check = false)
    if get_valid_moves.include?([target_r, target_c])
      unless check_move(target_r, target_c)
        return true if cm_check
        self.move(target_r, target_c)
        self.moved = true if self.class == King || Rook
      else
        return false if cm_check
        raise "That would put you in check."
      end

    else
      raise "That move's not possible!"
    end
  end

  def pawn_promote
    promote_r = (color == :black) ? 7 : 0
    return unless (self.class == Pawn && self.row == promote_r)

    puts "What would you like to promote to?"
    puts "(Q, R, B, K)"
    begin
      input = gets.chomp.upcase[0]
      case input
      when "Q"
        board[row, col] = Queen.new(color, row, col, board)
      when "R"
        board[row, col] = Rook.new(color, row, col, board)
      when "B"
        board[row, col] = Bishop.new(color, row, col, board)
      when "K"
        board[row, col] = Knight.new(color, row, col, board)
      else
        raise "Input not valid"
      end
    rescue => error
      puts error
      retry
    end
  end

  def check_move(target_r, target_c)
    start_r, start_c = row, col
    piece = board[target_r, target_c]

    self.move(target_r, target_c, true)
    makes_check = board.king_in_check?(color)
    self.move(start_r, start_c, true)

    board[target_r, target_c] = piece

    makes_check
  end
end