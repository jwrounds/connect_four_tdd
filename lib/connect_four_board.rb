class Board
  attr_reader :spaces
  def initialize
    @spaces = build_board
  end

  def build_board
    Array.new(6) {Array.new(7, false)}
  end

  def place_piece col, symbol
    5.downto(0) { |i| @spaces[i][col] = symbol unless @spaces[i][col] }
  end
end