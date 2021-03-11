class Player
  attr_reader :name

  def initialize name, piece
    @name = name
    @piece = piece
  end

  def play_piece board, column
    board.place_piece(column, @piece)
  end
end