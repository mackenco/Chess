require './piece.rb'

class Board
  #COLUMNS = [:a..:h]

  attr_accessor :board

  def initialize
    @board = Array.new(8) { Array.new(8) }
    self[0, 0] = King.new(:white, 0, 0, self)
    self[0, 3] = King.new(:white, 0, 3, self)
    self[2, 1] = King.new(:black, 2, 1, self)
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
          print "#{piece.unicode} "
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
game[0, 0].make_move(1, 1)
game.display
game[2, 1].make_move(2, 2)
game.display
game[0, 3].make_move(0, 2)
game.display