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

Game.new.play