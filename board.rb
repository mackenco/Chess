require './piece.rb'

class Board
  #COLUMNS = [:a..:h]

  attr_accessor :board

  def initialize
    @board = Array.new(8) { Array.new(8) }
    self[0, 0] = Rook.new(:white, 0, 0, self)
    self[0, 2] = Rook.new(:white, 0, 2, self)
    self[4, 0] = Rook.new(:black, 4, 0, self)
  end

  def [](row, col)
    #board[(num - 8).abs][COLUMNS.index(let)]
    board[row][col]
  end

  def []=(row, col, value)
    #self.board[(num - 8).abs][COLUMNS.index(let)] = value
    self.board[row][col] = value
  end

  def display
    puts ""
    header = 8
    board.each do |row|
      print "#{header} "
      row.each do |piece|
        if piece
          print "#{piece.label} "
        else
          print "  "
        end
      end
      print "\n"
      header -= 1
    end

    print "  a b c d e f g h\n"
    nil
  end

end

game = Board.new
game.display
game[0, 0].move(1, 6)
game.display