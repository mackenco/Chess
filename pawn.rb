class Pawn < Piece

  def initialize(color, row, col, board)
    color == :black ? @unicode = "\u265F" : @unicode = "\u2659"
    super(color, row, col, board, unicode)
  end

  def get_valid_moves
    moves_arr = []
    if color == :black
      i = 1
    else
      i = -1
    end

    moves_arr << [row + i, col] if board[row + i, col].nil?

    moves_arr << [row + (i * 2), col] if board[row + (i * 2), col].nil? if first_move?

    unless board[row + i, col + 1].nil? || board[row + i, col + 1].color == color
      moves_arr << [row + i, col + 1]
    end

    unless board[row + i, col - 1].nil? || board[row + i, col - 1].color == color
      moves_arr << [row + i, col - 1]
    end

    moves_arr
  end

  def first_move?
    if color == :black
      row == 1
    else
      row == 6
    end
  end
end