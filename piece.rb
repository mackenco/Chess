class Piece
  attr_accessor :color, :row, :col, :board, :label

  def initialize(color, row, col, board, label)
    @color = color
    @row = row
    @col = col
    @board = board
    @label = label
    nil
  end

  def move(new_row, new_col)
    move_coordinates = move_valid(new_row, new_col)
    if actual_move?(new_row, new_col) && move_coordinates
      m_row, m_col = move_coordinates[0], move_coordinates[1]
      @board[m_row, m_col] = self
      @board[row, col] = nil
      self.row = m_row
      self.col = m_col
      puts "moved the piece"
    end
  end

  def actual_move?(new_row, new_col)
     new_row != row || new_col != col
  end

  def collision_check?(coords)
    coords.each do |coord|
      if board[coord[0], coord[1]]
        return [board[coord[0], coord[1]].color, coord[0], coord[1]]
      end
    end
    [nil]
  end


end


class Rook < Piece

  def initialize(color, row, col, board)
    color == :black ? label = :R : label = :r
    super(color, row, col, board, label)
  end

  def move_valid(new_row, new_col)
    if new_row == row || new_col == col
      built_collision = build_collision(new_row, new_col)

      collision = collision_check?(built_collision)

      case collision[0]
      when nil
        return [new_row, new_col]
      when color
        return false
      else
        return [collision[1],collision[2]]
      end
    end
    false
  end

  def build_collision(new_row, new_col)
    coll_arr = []

    if new_col == col
      if new_row < row
        (new_row..row).to_a.reverse.each do |r|
          coll_arr << [r, col]
        end
      elsif row < new_row
        (row..new_row).to_a.each do |r|
          coll_arr << [r, col]
        end
      end
    elsif new_row == row
      if new_col < col
        (new_col..col).to_a.reverse.each do |c|
          coll_arr << [row, c]
        end
      elsif col < new_col
        (col..new_col).to_a.each do |c|
          coll_arr << [row, c]
        end
      end
    end

    coll_arr.delete_if { |coord| coord == [row, col] }
    coll_arr
  end

end