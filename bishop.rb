class Bishop < Piece
  def initialize(color, row, col, board)
    color == :black ? label = :B : label = :b
    color == :black ? @unicode = "\u265D" : @unicode = "\u2657"
    super(color, row, col, board, label, unicode)
  end

  def make_move(target_r, target_c)
    dup_board = board.clone
    dup_board.board = deep_dup(dup_board.board)

    move_distance = [target_r - row, target_c - col]
    free = true

    sign_v = move_distance[0] / move_distance[0].abs
    sign_h = move_distance[1] / move_distance[1].abs

    start_r = row
    start_c = col

    magnitude = move_distance[1]
    magnitude.abs.times do |count|
      distance_v = (count + 1) * sign_v
      distance_h = (count + 1) * sign_h
      unless verify_move?(start_r + distance_v, start_c + distance_h, target_r, target_c)
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
    (row - target_r).abs == (col - target_c).abs
  end
end