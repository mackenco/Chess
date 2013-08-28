module StraightMover
  def build_straight_moves
    vertical_moves(1) + vertical_moves(-1) + horizontal_moves(1) + horizontal_moves(-1)
  end

  def vertical_moves(dir)
    moves_arr = []
    break_arr = [-1,8]
    i = dir

    loop do
      break if break_arr.include?(row + i)
      if board[row + i, col].nil?
        moves_arr << [row + i, col]
        i += dir
      elsif board[row + i, col].color != color
        moves_arr << [row + i, col]
        break
      else
        break
      end
    end

    moves_arr
  end

  def horizontal_moves(dir)
    moves_arr = []
    break_arr = [-1,8]
    i = dir

    loop do
      break if break_arr.include?(col + i)
      if board[row, col + i].nil?
        moves_arr << [row, col + i]
        i += dir
      elsif board[row, col + i].color != color
        moves_arr << [row, col + i]
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
    same_signs(1) + same_signs(-1) + diff_signs(1) + diff_signs(-1)
  end

  def same_signs(dir)
    break_arr = [-1,8]
    moves_arr = []
    i = dir

    loop do
      break if break_arr.include?(row + i) || break_arr.include?(col + i)
      if board[row + i, col + i].nil?
        moves_arr << [row + i, col + i]
        i += dir
      elsif board[row + i, col + i].color != color
        moves_arr << [row + i, col + i]
        break
      else
        break
      end
    end
    moves_arr
  end

  def diff_signs(dir)
    break_arr = [-1,8]
    moves_arr = []
    i = dir

    loop do
      break if break_arr.include?(row + i) || break_arr.include?(col - i)
      if board[row + i, col - i].nil?
        moves_arr << [row + i, col - i]
        i += dir
      elsif board[row + i, col - i].color != color
        moves_arr << [row + i, col - i]
        break
      else
        break
      end
    end
    moves_arr
  end
end