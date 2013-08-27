require './rook.rb'

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

