class King < Piece
  def initialize(color, row, col, board)
    color == :black ? label = :X : label = :x
    color == :black ? @unicode = "\u265A" : @unicode = "\u2654"
    super(color, row, col, board, label, unicode)
  end

  def make_move(target_r, target_c)
    dup_board = board.clone
    dup_board.board = deep_dup(dup_board.board)

    move_distance = [target_r - row, target_c - col]
    free = true

    if move_distance[0] == 0
      sign = move_distance[1]
      unless verify_move?(row, col + sign, target_r, target_c)
        free = false
      end

      move_horizontal(sign, dup_board)
    elsif move_distance[1] == 0
      sign = move_distance[0]
      unless verify_move?(row + sign, col, target_r, target_c)
        free = false
      end

      move_vertical(sign, dup_board)
    else
      sign_v = move_distance[0]
      sign_h = move_distance[1]
      unless verify_move?(row + sign_v, col + sign_h, target_r, target_c)
        free = false
      end

      move_diagonal(sign_h, sign_v, dup_board)
    end

    if free
      @board.board = dup_board.board
    else
      raise ArgumentError.new("Invalid Move")
    end
  end

  def valid_move?(target_r, target_c)
    (row - target_r).abs == 1 || (col - target_c).abs == 1
  end
end