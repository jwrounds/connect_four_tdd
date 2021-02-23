require_relative '../lib/connect_four.rb'
require_relative '../lib/connect_four_player.rb'
require_relative '../lib/connect_four_board.rb'

describe Game do
  describe '#game_over?' do
    subject(:game_won) { described_class.new }

    context 'when there are four pieces of a single type in a row' do
      it 'returns true' do
        expect(game_won).to be_game_over
      end
    end
  end

  describe '#check_winner' do
    subject(:game_won) { described_class.new }

    context 'when there are four pieces of a single type in a row' do
      it 'returns the player who owns the pieces' do
        winner = Player.new('One', 'X')
        4.times { winner.play_piece(Board.new, 0) }

        expect(game_won.check_winner).to eq(winner)
      end
    end
  end
end

describe Player do
  describe '#play_piece' do
    subject(:current_player) { described_class.new('Jon', 'X') }

    context 'when a player plays a game token' do
      it 'places the token on the game board' do
        column = 0
        board = Board.new
        expect{ current_player.play_piece(board, column)}.to change{ board }
      end
    end
  end
end