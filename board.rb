class Board

  attr_accessor :board, :wk, :bk

  def initialize
    @board = Array.new(8) { Array.new(8) }

    @board[6].each_index { |i| self[6, i] = Pawn.new(:white, 6, i, self) }
    @board[1].each_index { |i| self[1, i] = Pawn.new(:black, 1, i, self) }

    arr = [[:white, 7], [:black, 0]]

     arr.each do |i|
       color = i[0]
       r = i[1]
       self[r, 0] = Rook.new(color, r, 0, self)
       self[r, 7] = Rook.new(color, r, 7, self)
       self[r, 2] = Bishop.new(color, r, 2, self)
       self[r, 5] = Bishop.new(color, r, 5, self)
       self[r, 3] = Queen.new(color, r, 3, self)
       self[r, 4] = King.new(color, r, 4, self)
       self[r, 1] = Knight.new(color, r, 1, self)
       self[r, 6] = Knight.new(color, r, 6, self)
     end
     @bk, @wk = self[0, 4], self[7, 4]

  end

  def [](row, col)
    board[row][col]
  end

  def []=(row, col, value)
    self.board[row][col] = value
  end

  def king_in_check?(color)
    check = false
    color == :black ? king_pos = [bk.row, bk.col] : king_pos = [wk.row, wk.col]

    board.each do |row|
      row.each do |space|
        next if space.nil?
        next if space.color == color
        check = true if space.get_valid_moves.include?(king_pos)
      end
    end

    check
  end

  def king_in_checkmate?(color)
    board.each do |row|
      row.each do |space|
        next if space.nil?
        next unless space.color == color
        space.get_valid_moves.each do |move|
          return false if space.make_move(move[0], move[1], true)
        end
      end
    end

    true
  end

  def castle(color, target_c)
    target_r = (color == :black) ? 0 : 7
    case target_c
    when 2 then queenside(target_r)
    when 6 then kingside(target_r)
    else
      raise "Not a valid castle"
    end
  end

  def queenside(row)
    raise "You already moved!" if self[row, 4].moved || self[row, 0].moved

    king = (row == 0) ? @bk : @wk
    rook = self[row, 0]

    3.downto(1) do |c|
      raise "Pieces in your way" unless self[row, c].nil?
      raise "Can't castle through a check" if king.check_move(row, c)
    end

    self[row, 2] = king
    self[row, 3] = rook
    king.col, rook.col = 2, 3
    self[row, 4], self[row, 0] = nil
  end

  def kingside(row)
    raise "You already moved!" if self[row, 4].moved || self[row, 7].moved

    king = (row == 0) ? @bk : @wk
    rook = self[row, 7]

    5.upto(6) do |c|
      raise "Pieces in your way" unless self[row, c].nil?
      raise "Can't castle through a check" if king.check_move(row, c)
    end

    self[row, 6] = king
    self[row, 5] = rook
    king.col, rook.col = 6, 5
    self[row, 4], self[row, 7] = nil
  end

  def display
    shaded = false
    puts ""
    header = 8
    board.each do |row|
      print "#{header} "
      row.each do |piece|
        if piece
          if shaded
            print " #{piece.unicode} ".colorize(background: :white)
          else
            print " #{piece.unicode} ".colorize(background: :red)
          end
        else
          if shaded
            print "   ".colorize(background: :white)
          else
            print "   ".colorize(background: :red)
          end
        end
        shaded = !shaded
      end
      print "\n"
      header -= 1
      shaded = !shaded
    end

    print "   a  b  c  d  e  f  g  h\n"
  end

end