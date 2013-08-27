class Rook < Piece

  def initialize(color, row, col, board)
    color == :black ? label = :R : label = :r
    color == :black ? @unicode = "\u265C" : @unicode = "\u2656"
    super(color, row, col, board, label, unicode)
  end

  def make_move(target_r, target_c)
    dup_board = board.clone
    dup_board.board = deep_dup(dup_board.board)

    move_distance = [row - target_r, col - target_c]
    free = true

    case move_distance[0]
    when 0
      magnitude = move_distance[1]
      sign = magnitude / magnitude.abs
      (magnitude).abs.times do |count|
        distance = (count - 1) * sign
        unless verify_move?(row, col + distance, target_r, target_c)
          free = false
        end

        move_horizontal(sign, dup_board)
      end
    else
      magnitude = move_distance[0]
      sign = -1 * (magnitude / magnitude.abs)
      (magnitude).abs.times do |count|
        distance = (count - 1) * sign
        unless verify_move?(row, col + distance, target_r, target_c)
          free = false
        end

        move_vertical(sign, dup_board)
      end
    end

    if free
      @board.board = dup_board.board
    else
      raise ArgumentError.new("Invalid Move")
    end
  end

  def valid_move?(target_r, target_c)
    row == target_r || col == target_c
  end
end