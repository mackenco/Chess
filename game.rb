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

  attr_accessor :board, :player1, :player2, :players

  def initialize
    @board = Board.new
    @player1 = HumanPlayer.new(:white, @board, self)
    @player2 = HumanPlayer.new(:black, @board, self)
    @players = { @player1 => :white, @player2 => :black }
  end

  def play
    board.display
    current_player = @player1

    loop do
      color = players[current_player]

      current_player.in_check = board.king_in_check?(color)
      if board.king_in_checkmate?(color)
        puts "#{color}: you lose" if current_player.in_check
        puts "Stalemate" unless current_player.in_check
        break
      end
      current_player.take_turn
      board.display

      current_player = (current_player == @player1) ? @player2 : @player1
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