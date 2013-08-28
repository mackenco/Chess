require './modules.rb'
require './piece.rb'
require './rook.rb'
require './queen.rb'
require './king.rb'
require './pawn.rb'
require './knight.rb'
require './bishop.rb'
require './board.rb'
require './humanplayer'
require 'colorize'
require 'yaml'

class Game

  attr_accessor :board, :player1, :player2

  def initialize
    @board = Board.new
    @player1 = HumanPlayer.new(:white, @board, self)
    @player2 = HumanPlayer.new(:black, @board, self)
  end

  def play

    loop do
      board.display
      if board.king_in_checkmate?(:white)
        puts "White: you lose"
        break
      end
      player1.take_turn
      player2.in_check = board.king_in_check?(:black)

      if board.king_in_checkmate?(:black)
        puts "Black: you lose"
        break
      end

      board.display
      player2.take_turn
      player1.in_check = board.king_in_check?(:white)
    end
  end

  def save
    File.open('chess_save.txt', 'w') { |file| file.puts self.to_yaml }
    raise "File saved"
  end
end

puts "New game or load a saved game?"
input = gets.chomp.downcase[0]
if input == "l"
  file = File.read("chess_save.txt")
  game = YAML::load(file)
else
  puts "Starting a new game"
  game = Game.new
end

game.play