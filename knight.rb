class Knight < Piece
  def initialize(color, row, col, board)
    color == :black ? @unicode = "\u265E" : @unicode = "\u2658"
    super(color, row, col, board, unicode)
  end

  def make_move(target_r, target_c)
    dup_board = board.clone
    dup_board.board = deep_dup(dup_board.board)

    if @board[target_r, target_c].nil? || @board[target_r, target_c].color != color
      board[target_r, target_c] = self
      board[row, col] = nil
      self.row = target_r
      self.col = target_c
    else
      raise ArgumentError.new("Invalid Move")
    end
  end

  def valid_move?(target_r, target_c)
    two_and_one = (row - target_r).abs == 1 && (col - target_c).abs == 2
    one_and_two = (row - target_r).abs == 2 && (col - target_c).abs == 1
    two_and_one || one_and_two
  end
end