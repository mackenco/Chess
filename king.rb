class King < Piece
  KING_MOVES = [[1, 1], [-1, 1], [1, -1], [-1, -1],
                  [0, 1], [1, 0], [0, -1], [-1, 0]]

  def initialize(color, row, col, board)
    color == :black ? @unicode = "\u265A" : @unicode = "\u2654"
    super(color, row, col, board, unicode)
  end

  def get_valid_moves
    moves_arr = []
    next_arr = [-1, 8]

    KING_MOVES.each do |move|
      new_r = move[0] + row
      new_c = move[1] + col
      next if next_arr.include?(new_r) || next_arr.include?(new_c)
      next unless board[new_r, new_c].nil? || board[new_r, new_c].color != color
      moves_arr << [new_r, new_c]
    end
    moves_arr
  end
end