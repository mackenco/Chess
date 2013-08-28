require './modules.rb'
require './piece.rb'
require './rook.rb'
require './queen.rb'
require './king.rb'
require './pawn.rb'
require './knight.rb'
require './bishop.rb'
require './board.rb'
require 'colorize'

class Game

  attr_accessor :board, :player1, :player2

  def initialize
    @board = Board.new
    @player1 = HumanPlayer.new(:white, @board)
    @player2 = HumanPlayer.new(:black, @board)
  end

  def play
   loop do
      board.display
      unless board.not_checkmate?(:white)
        puts "White: you lose"
        break
      end
      player1.take_turn
      player2.in_check = board.king_in_check?(:black)

      unless board.not_checkmate?(:black)
        puts "Black: you lose"
        break
      end

      board.display
      player2.take_turn
      player1.in_check = board.king_in_check?(:white)

    end
  end

end

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
      end_col = COLUMNS.index(input[1][0])
      end_row = ROWS.index(input[1][1])
      piece = @board[start_row, start_col]

      if piece.color == color
        piece.make_move(end_row, end_col)
      else
        raise "That's not your piece!"
      end
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


Game.new.play