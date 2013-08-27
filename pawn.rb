class Pawn < Piece

  def initialize(color, row, col, board)
    color == :black ? label = :R : label = :r
    color == :black ? @unicode = "\u265F" : @unicode = "\u2659"
    super(color, row, col, board, label, unicode)
  end

  def make_move(target_r, target_c)
    dup_board = board.clone
    dup_board.board = deep_dup(dup_board.board)

    move_distance = [target_r - row, target_c - col]
    free = true

    start_r = row
    start_c = col

    if can_take?(target_r, target_c)
      dup_board[target_r, target_c] = self
      dup_board[row, col] = nil
      self.row = target_r
      self.col = target_c
    else
      magnitude = move_distance[0]
      sign = magnitude / magnitude.abs
      (magnitude).abs.times do |count|
        distance = (count + 1) * sign
        unless verify_move?(start_r + distance, start_c, target_r, target_c)
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
    return can_take?(target_r, target_c) if target_c != col

    if color == :black
      unless first_move?
        return target_r == row + 1
      else
        return target_r == row + 1 || target_r == row + 2
      end
    else
      unless first_move?
        return target_r == row - 1
      else
        return target_r == row - 1 || target_r == row - 2
      end
    end
  end

  def can_take?(target_r, target_c)
    return false if board[target_r, target_c].nil?

    case color
    when :black
      target_r - row == 1 && (target_c - col).abs == 1 && board[target_r, target_c].color == :white
    else
      row - target_r == 1 && (col - target_c).abs == 1 && board[target_r, target_c].color == :black
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