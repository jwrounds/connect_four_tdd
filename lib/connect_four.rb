require_relative '../lib/connect_four_player.rb'
require_relative '../lib/connect_four_board.rb'

class Game
  attr_reader :winner, :board
  
  def initialize board = Board.new
    @board = board
    @winner = nil
  end

  def game_over?
    check_winner || check_full 
  end

  def check_full
    @board.spaces.each do |row| 
      return false if row.include?(false)
    end
    true
  end

  def check_winner
    check_rows || check_columns || check_diagonals
  end

  def check_rows rows = @board.spaces
    rows.each do |row|
      in_row = 0
      row.each_with_index do |space, i|
        in_row += 1 if space
        if space && row[i+1]
          in_row += 1 if space == row[i+1]
          return true if in_row == 4
        else
          in_row = 0
        end
      end
    end
  end

  def check_columns

  end

  def check_diagonals

  end
end
