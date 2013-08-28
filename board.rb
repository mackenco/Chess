class Board

  attr_accessor :board

  def initialize
    @board = Array.new(8) { Array.new(8) }

    # @board[6].each_index { |i| self[6, i] = Pawn.new(:white, 6, i, self) }
   #  @board[1].each_index { |i| self[1, i] = Pawn.new(:black, 1, i, self) }
    self[7, 0] = Rook.new(:white, 7, 0, self)
    self[7, 7] = Rook.new(:white, 7, 7, self)
    self[0, 0] = Rook.new(:black, 0, 0, self)
    self[0, 7] = Rook.new(:black, 0, 7, self)
    self[7, 2] = Bishop.new(:white, 7, 2, self)
    self[7, 5] = Bishop.new(:white, 7, 5, self)
    self[0, 2] = Bishop.new(:black, 0, 2, self)
    self[0, 5] = Bishop.new(:black, 0, 5, self)
    self[7, 3] = Queen.new(:white, 7, 3, self)
    self[0, 3] = Queen.new(:black, 0, 3, self)
    # self[7, 4] = King.new(:white, 7, 4, self)
    # self[0, 4] = King.new(:black, 0, 4, self)
    self[7, 1] = Knight.new(:white, 7, 1, self)
    self[7, 6] = Knight.new(:white, 7, 6, self)
    self[0, 1] = Knight.new(:black, 0, 1, self)
    self[0, 6] = Knight.new(:black, 0, 6, self)
  end

  def [](row, col)
    board[row][col]
  end

  def []=(row, col, value)
    self.board[row][col] = value
  end



  def display
    shaded = true
    puts ""
    header = 8
    board.each do |row|
      print "#{header} "
      row.each do |piece|
        if piece
          if shaded
            print "#{piece.unicode} ".colorize(background: :light_white)
          else
            print "#{piece.unicode} "
          end
        else
          if shaded
            print "  ".colorize(background: :light_white)
          else
            print "  "
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

# game = Board.new
# game.display
# game[7, 0].make_move(6, 0)
# game.display
# # game[5, 1].make_move(4, 2)
# # game.display
# # game[1, 1].make_move(2, 1)
# # game.display