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
        if space
          in_row += 1 if space == row[i+1] || space == row[i-1]
          return true if in_row == 4
        else
          in_row = 0
        end
      end
    end
    false
  end

  def check_columns
    row = 0
    column = 0
    row_length = @board.spaces.length
    column_length = @board.spaces[0].length

    while column < column_length
      row = 0
      in_row = 0
      while row < row_length
        space = @board.spaces[row][column]
        
        # if next and last spaces are valid, initialize them as variables
        next_space = @board.spaces[row+1][column] if row < row_length-1
        last_space = @board.spaces[row-1][column] if column < column_length-1

        if space
          in_row += 1 if space == next_space || space == last_space
          return true if in_row == 4
        else
          in_row = 0
        end
        row += 1
      end
      column += 1
    end
    false
  end

  def check_diagonals
    false
  end
end
