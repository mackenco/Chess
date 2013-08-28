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
    while true
      board.display
      player1.take_turn
      board.display
      player2.take_turn
    end
  end

end

class HumanPlayer
  COLUMNS = %w(a b c d e f g h)
  ROWS = %w(8 7 6 5 4 3 2 1)

  attr_accessor :color, :board

  def initialize(color, board)
    @color = color
    @board = board
  end

  def take_turn
    begin
      puts "#{color.to_s.capitalize}, enter move:"
      input = gets.chomp.split(", ")
      raise "Incorrect move format" unless input.count == 2
      input.each do |inp|
        raise "Incorrect move format" unless inp.length == 2
        raise "Not a valid space" unless COLUMNS.include?(inp[0]) && ROWS.include?(inp[1])
      end

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
end

Game.new.play