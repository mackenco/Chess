module StraightMover
  def build_straight_moves
    build_vertical_moves + build_horizontal_moves
  end

  def build_vertical_moves
    moves_arr = []

    i = row + 1
    while i < 8
      if board[i, col].nil?
        moves_arr << [i, col]
        i += 1
      elsif board[i, col].color != color
        moves_arr << [i, col]
        break
      else
        break
      end
    end

    (row - 1).downto(0) do |i|
      if board[i, col].nil?
        moves_arr << [i, col]
      elsif board[i, col].color != color
        moves_arr << [i, col]
        break
      else
        break
      end
    end

    moves_arr
  end


  def build_horizontal_moves
    moves_arr = []
    i = col + 1

    while i < 8
      if board[row, i].nil?
        moves_arr << [row, i]
        i += 1
      elsif board[row, i].color != color
        moves_arr << [row, i]
        break
      else
        break
      end
    end

    (col - 1).downto(0) do |i|
      if board[row, i].nil?
        moves_arr << [row, i]
      elsif board[row, i].color != color
        moves_arr << [row, i]
        break
      else
        break
      end

    end
    moves_arr
  end


end

module DiagonalMover
  def build_diagonal_moves

  end

end