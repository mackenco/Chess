class Queen < Piece
  def initialize(color, row, col, board)
    color == :black ? label = :Q : label = :q
    color == :black ? @unicode = "\u265B" : @unicode = "\u2655"
    super(color, row, col, board, label, unicode)
  end

  def make_move(target_r, target_c)
    dup_board = board.clone
    dup_board.board = deep_dup(dup_board.board)

    move_distance = [row - target_r, col - target_c]
    free = true

    if move_distance[0] == 0
      magnitude = move_distance[1]
      sign = magnitude / magnitude.abs
      (magnitude).abs.times do |count|
        distance = (count - 1) * sign
        unless verify_move?(row, col + distance, target_r, target_c)
          free = false
        end

        move_horizontal(sign, dup_board)
      end
    elsif move_distance[1] == 0
      magnitude = move_distance[0]
      sign = -1 * (magnitude / magnitude.abs)
      (magnitude).abs.times do |count|
        distance = (count - 1) * sign
        unless verify_move?(row, col + distance, target_r, target_c)
          free = false
        end
        move_vertical(sign, dup_board)
      end
    else
      sign_v = (move_distance[0] / move_distance[0].abs) * -1
      sign_h = (move_distance[1] / move_distance[1].abs) * -1

      magnitude = move_distance[1]
      magnitude.abs.times do |count|
        distance_v = (count - 1) * sign_v
        distance_h = (count - 1) * sign_h
        unless verify_move?(row + distance_v, col + distance_h, target_r, target_c)
          free = false
        end

        move_diagonal(sign_h, sign_v, dup_board)
      end
    end

    if free
      @board.board = dup_board.board
    else
      raise ArgumentError.new("Invalid Move")
    end
  end

  def valid_move?(target_r, target_c)
    diagonal = (row - target_r).abs == (col - target_c).abs
    straight = target_r || col == target_c
    diagonal || straight
  end
end