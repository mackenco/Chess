module StraightMover
  def build_straight_moves
    build_vertical_moves + build_horizontal_moves
  end

  def build_vertical_moves
    moves_arr = []

    (row + 1).upto(7) do |i|
      if board[i, col].nil?
        moves_arr << [i, col]
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

    (col + 1).upto(7) do |i|
      if board[row, i].nil?
        moves_arr << [row, i]
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
    build_same_signs + build_diff_signs
  end

  def build_same_signs
    moves_arr = []
    i = 1
    break_arr = [-1,8]

    loop do
      break if break_arr.include?(row + i) || break_arr.include?(col + i)
      if board[row + i, col + i].nil?
        moves_arr << [row + i, col + i]
        i += 1
      elsif board[row + i, col + i].color != color
        moves_arr << [row + i, col + i]
        break
      else
        break
      end
    end

    i = 1
    loop do
      break if break_arr.include?(row - i) || break_arr.include?(col - i)
      if board[row - i, col - i].nil?
        moves_arr << [row - i, col - i]
        i += 1
      elsif board[row - i, col - i].color != color
        moves_arr << [row - i, col - i]
        break
      else
        break
      end
    end
    moves_arr
  end

  def build_diff_signs
    moves_arr = []
    i = 1
    break_arr = [-1,8]

    loop do
      break if break_arr.include?(row + i) || break_arr.include?(col - i)
      if board[row + i, col - i].nil?
        moves_arr << [row + i, col - i]
        i += 1
      elsif board[row + i, col - i].color != color
        moves_arr << [row + i, col - i]
        break
      else
        break
      end
    end

    i = 1

    loop do
      break if break_arr.include?(row - i) || break_arr.include?(col + i)
      if board[row - i, col + i].nil?
        moves_arr << [row - i, col + i]
        i += 1
      elsif board[row - i, col + i].color != color
        moves_arr << [row - i, col + i]
        break
      else
        break
      end
    end

    moves_arr
  end

end