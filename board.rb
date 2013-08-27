class Board
  #COLUMNS = [:a..:h]

  attr_accessor :board

  def initialize
    @board = Array.new(8) { Array.new(8) }
  end

  def [](row, col)
    #board[(num - 8).abs][COLUMNS.index(let)]
    board[row][col]
  end

  def []=(row, col, value)
    #self.board[(num - 8).abs][COLUMNS.index(let)] = value
    self.board[row][col] = value
  end

end