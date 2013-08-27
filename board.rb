class Board
  COLUMNS = ["a".."h"]
  attr_accessor :board

  def initialize
    @board = Array.new(8) { Array.new(8) }
  end

  def [](let, num)
    board[num - 1][COLUMNS.index(let)]
  end

  def []=(let, num, value)
    self.board[num - 1][COLUMNS.index(let)] = value
  end

end