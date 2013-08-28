class Knight < Piece
  KNIGHT_MOVES = [[-2, 1], [2, 1], [2, -1], [-2, -1],
                  [-1, 2], [1, 2], [1, -2], [-1, -2]]

  def initialize(color, row, col, board)
    color == :black ? @unicode = "\u265E" : @unicode = "\u2658"
    super(color, row, col, board, unicode)
  end

  def get_valid_moves
    next_arr = [-2, -1, 8, 9]
    moves_arr = []

    KNIGHT_MOVES.each do |move|
      new_r = move[0] + row
      new_c = move[1] + col
      next if next_arr.include?(new_r) || next_arr.include?(new_c)
      next unless board[new_r, new_c].nil? || board[new_r, new_c].color != color

      moves_arr << [new_r, new_c]
    end
    moves_arr
  end
end