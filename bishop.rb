class Bishop < Piece
  include DiagonalMover
  def initialize(color, row, col, board)
    color == :black ? @unicode = "\u265D" : @unicode = "\u2657"
    super(color, row, col, board, unicode)
  end

  def get_valid_moves
    build_diagonal_moves
  end
end