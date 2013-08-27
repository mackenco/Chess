class Pawn < Piece

  def initialize(color, row, col, board)
    color == :black ? label = :R : label = :r
    color == :black ? @unicode = "\u265F" : @unicode = "\u2659"
    super(color, row, col, board, label, unicode)
  end

  def make_move(target_r, target_c)
    dup_board = board.clone
    dup_board.board = deep_dup(dup_board.board)

    move_distance = [row - target_r, col - target_c]
    free = true

    magnitude = move_distance[0]
    sign = -1 * (magnitude / magnitude.abs)
    (magnitude).abs.times do |count|
      distance = (count - 1) * sign
      unless verify_move?(row, col + distance, target_r, target_c)
        free = false
      end

      move_vertical(sign, dup_board)
    end

    if free
      @board.board = dup_board.board
    else
      raise ArgumentError.new("Invalid Move")
    end
  end

  def valid_move?(target_r, target_c)
    if color == :black
      unless first_move?
        target_r == row + 1
      else
        target_r.between?(row + 1, row + 2)
      end
    else
      unless first_move?
        target_r == row - 1
      else
        target_r.between?(row - 1, row - 2)
      end
    end
  end

  def first_move?
    if color == :black
      row == 1
    else
      row == 6
    end
  end
end