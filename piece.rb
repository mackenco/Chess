class Piece
  attr_accessor :color, :row, :col, :board, :label, :unicode

  def initialize(color, row, col, board, label, unicode)
    @color = color
    @row = row
    @col = col
    @board = board
    @label = label
  end

  def move_horizontal(dir, board)
    board[row, col + dir] = self
    board[row, col] = nil
    self.col += dir
  end

  def move_vertical(dir, board)
    board[row + dir, col] = self
    board[row, col] = nil
    self.row += dir
  end

  def move_diagonal(dir_h, dir_v, board)
    board[row + dir_v, col + dir_h] = self
    board[row, col] = nil
    self.row += dir_v
    self.col += dir_h
  end

  def deep_dup(arr)
    temp_array=[]
    arr.each{|sub| temp_array << sub.dup}
    temp_array
  end

  def verify_move?(row, col, target_r, target_c)
    return true if board[row, col].nil?
    if row == target_r && col == target_c && board[row, col].color != color
      return true
    end
    false
  end
end

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

class Bishop < Piece
  def initialize(color, row, col, board)
    color == :black ? label = :B : label = :b
    color == :black ? @unicode = "\u265D" : @unicode = "\u2657"
    super(color, row, col, board, label, unicode)
  end

  def make_move(target_r, target_c)
    dup_board = board.clone
    dup_board.board = deep_dup(dup_board.board)

    move_distance = [row - target_r, col - target_c]
    free = true

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

class Knight < Piece
  def initialize(color, row, col, board)
    color == :black ? label = :K : label = :k
    color == :black ? @unicode = "\u265E" : @unicode = "\u2658"
    super(color, row, col, board, label, unicode)
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

class King < Piece
  def initialize(color, row, col, board)
    color == :black ? label = :X : label = :x
    color == :black ? @unicode = "\u265A" : @unicode = "\u2654"
    super(color, row, col, board, label, unicode)
  end

  def make_move(target_r, target_c)
    dup_board = board.clone
    dup_board.board = deep_dup(dup_board.board)

    move_distance = [row - target_r, col - target_c]
    free = true

    if move_distance[0] == 0
      sign = move_distance[1] * -1
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
      sign_v = move_distance[0] * -1
      sign_h = move_distance[1] * -1
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
