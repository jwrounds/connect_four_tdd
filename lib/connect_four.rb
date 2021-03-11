require_relative '../lib/connect_four_player.rb'
require_relative '../lib/connect_four_board.rb'

class Game
  attr_reader :winner, :board, :players
  
  def initialize board = Board.new
    @board = board
    @winner = nil
    @players = []
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

  def set_players
    puts "\nFirst player, please enter your name: "
    player_one_name = gets.chomp
    puts "First player, please enter your symbol: "
    player_one_symbol = gets.chomp
    @players.push(Player.new(player_one_name, player_one_symbol))

    puts "\nSecond player, please enter your name: "
    player_two_name = gets.chomp 
    puts "Second player, please enter your symbol: "
    player_two_symbol = gets.chomp
    @players.push(Player.new(player_two_name, player_two_symbol))
  end

  def play_game
    introduction
    set_players

    current = nil;

    while !game_over?
      current == @players[0] ? current = @players[1] : current = @players[0]
      print_board
      puts "#{current.name} enter a column (0 to 6) to play your piece: "
      chosen_column = gets.chomp.to_i
      current.play_piece @board, chosen_column
    end

    check_winner ? @winner = current : @winner = nil
    if winner 
      puts "#{@winner.name} wins!"
    else
      puts "Tie game!"
    end
  end

  private

  def introduction
    puts ">>> PLAY THE CLASSIC GAME OF CONNECT FOUR <<<\n\nTake turns placing game pieces on the board. Choose one of 7 columns, and your piece will 'slide' to the bottom. Stack four in a row vertically, line them up horizontally, or even surprise your opponent with four of your pieces arrayed diagonally!\n\n>>> The first to CONNECT FOUR wins! <<<\n\n"
  end

  def print_board board = @board.spaces
    board.each do |row|
      str = ""
      row.each do |space| 
        space ? str += "_#{space}_|" : str += "___|"
      end
      puts str
    end
  end

end
