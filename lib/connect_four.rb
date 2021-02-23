require_relative '../lib/connect_four_player.rb'
require_relative '../lib/connect_four_board.rb'

class Game
  attr_reader :winner, :board
  
  def initialize board: Board.new
    @board = board
    @winner = nil
  end

  def game_over?
    check_winner
  end

  def check_winner

  end
end
