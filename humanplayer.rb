class HumanPlayer
  COLUMNS = %w(a b c d e f g h)
  ROWS = %w(8 7 6 5 4 3 2 1)

  attr_accessor :color, :board, :in_check

  def initialize(color, board)
    @color = color
    @board = board
    @in_check = false
  end

  def take_turn
    begin
      puts "#{color.to_s.capitalize}, enter move:"
      puts "(You're in check.)" if in_check
      input = gets.chomp.split(", ")
      input_check(input)

      start_col = COLUMNS.index(input[0][0])
      start_row = ROWS.index(input[0][1])
      target_col = COLUMNS.index(input[1][0])
      target_row = ROWS.index(input[1][1])

      piece = @board[start_row, start_col]

      raise "That's not your piece!" unless piece.color == color
      piece.make_move(target_row, target_col)

    rescue => error
      puts error
      retry
    end
  end

  def input_check(input)
    raise "Incorrect move format" unless input.count == 2
    input.each do |inp|
      raise "Incorrect move format" unless inp.length == 2
      raise "Not a valid space" unless COLUMNS.include?(inp[0]) && ROWS.include?(inp[1])
    end
  end
end