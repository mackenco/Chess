class Queen < Piece
  include StraightMover, DiagonalMover

  def initialize(color, row, col, board)
    color == :black ? @unicode = "\u265B" : @unicode = "\u2655"
    super(color, row, col, board, unicode)
  end

  def get_valid_moves
    build_straight_moves + build_diagonal_moves
  end
end