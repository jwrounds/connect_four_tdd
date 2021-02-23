class Board
  attr_reader :spaces
  def initialize
    @spaces = build_board
  end

  def build_board
    Array.new(6) {Array.new(7, false)}
  end

  def place_piece col, symbol
    row = @spaces.length - 1
    while row > 0 do
      return @spaces[row][col] = symbol unless @spaces[row][col]
      row -= 1
    end
  end
end