class HumanPlayer
  COLUMNS = %w(a b c d e f g h)
  ROWS = %w(8 7 6 5 4 3 2 1)

  attr_accessor :color, :board, :in_check, :game

  def initialize(color, board, game)
    @color = color
    @board = board
    @in_check = false
    @game = game
  end

  def take_turn
    begin
      puts "#{color.to_s.capitalize}, enter move:"
      puts "(You're in check.)" if in_check
      input = gets.chomp.split(", ")

      if input[0].downcase == "save"
        game.save
      elsif input[0].downcase == "castle"
        raise "You can't castle out of check" if @in_check
        castle(input[1].downcase[0])
      else
        normal_move(input)
      end

    rescue => error
      puts error
      retry
    end
  end

  def normal_move(input)

    input_check(input)

    start_col = COLUMNS.index(input[0][0])
    start_row = ROWS.index(input[0][1])
    target_col = COLUMNS.index(input[1][0])
    target_row = ROWS.index(input[1][1])

    piece = @board[start_row, start_col]

    raise "That's not your piece!" unless piece.color == color
    piece.make_move(target_row, target_col)
  end

  def castle(side)
    case side
    when "q"
      board.castle(color, 2)
    when "k"
      board.castle(color, 6)
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