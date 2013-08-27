require './piece.rb'
require './rook.rb'
require './queen.rb'
require './king.rb'
require './pawn.rb'
require './knight.rb'
require './bishop.rb'

class Board
  #COLUMNS = [:a..:h]

  attr_accessor :board

  def initialize
    @board = Array.new(8) { Array.new(8) }
    self[6, 0] = Pawn.new(:white, 6, 0, self)
    self[6, 8] = Pawn.new(:white, 6, 8, self)
    self[1, 1] = Pawn.new(:black, 1, 1, self)
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
game[6, 0].make_move(4, 0)
game.display
game[4, 0].make_move(3, 0)
game.display
game[1, 1].make_move(2, 1)
game.display