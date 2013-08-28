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

    print "  a b c d e f g h\n"
  end

end