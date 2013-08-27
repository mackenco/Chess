require './piece.rb'

class Board
  #COLUMNS = [:a..:h]

  attr_accessor :board

  def initialize
    @board = Array.new(8) { Array.new(8) }
    self[0, 0] = Rook.new(:white, 0, 0, self)
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

    print "  a b c d e f g h"
  end

end