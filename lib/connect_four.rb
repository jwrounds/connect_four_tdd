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
        # check current space for a valid piece, then whether it's neighbors are of the same type
        if space
          in_row += 1 if space == row[i+1] || space == row[i-1]
          return true if in_row == 4
        # reset if neighboring piece differs
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

        # check current piece, and whether it's in sequence with its neighbors
        if space
          in_row += 1 if space == next_space || space == last_space
          return true if in_row == 4
        # reset if neighboring piece differs
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
    row_length = @board.spaces.length
    column_length = @board.spaces[0].length

    # left to right, top to bottom check
    @board.spaces.each do
      in_row = 0
      row = 0
      column = 0

      if row < 3 && column < 4 
        while column < column_length && row < row_length
          space = @board.spaces[row][column]
          next_space = nil
          last_space = nil

          # if next and last spaces are within the bounds of the game board, initialize them as variables
          if row < row_length-1 && column < column_length-1 
            next_space = @board.spaces[row+1][column+1]     
          end

          if row > 0 && column > 0
            last_space = @board.spaces[row-1][column-1]
          end
          
          # check current space, then its neighbors 
          if space
            in_row += 1 if space == next_space || space == last_space
            return true if in_row == 4
          # reset if neighboring piece differs
          else
            in_row = 0
          end

          column += 1
          row += 1
        end
      else 
        next  
      end
    end

    # right to left, top to bottom check
    @board.spaces.each_index do |i|
      in_row = 0
      @board.spaces[i].each_index do |j|
        if i < 3 && j > 2
          row = i
          column = j
          while row < row_length && column < column_length
            space = @board.spaces[row][column]
            next_space = nil
            last_space = nil
  
            # if next and last spaces are within the bounds of the game board, initialize them as variables
            if row < row_length-1 && column > 0
              next_space = @board.spaces[row+1][column-1]     
            end
  
            if row > 0 && column < column_length-1
              last_space = @board.spaces[row-1][column+1]
            end
            
            # check current space, then its neighbors 
            if space
              in_row += 1 if space == next_space || space == last_space
              return true if in_row == 4
            # reset if neighboring piece differs
            else
              in_row = 0
            end
  
            column -= 1
            row += 1
          end
        else
          next
        end
      end
    end

    false
  end
end
