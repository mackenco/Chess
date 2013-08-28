class Rook < Piece
  include StraightMover

  def initialize(color, row, col, board)
    color == :black ? @unicode = "\u265C" : @unicode = "\u2656"
    super(color, row, col, board, unicode)
  end

  def get_valid_moves
    build_straight_moves
  end

  def make_move(target_r, target_c)
    if get_valid_moves.include?([target_r, target_c])
      self.move(target_r, target_c)
    else
      raise "That move's not possible!"
    end
  end

end