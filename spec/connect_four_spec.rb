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
        4.times { winner.play_piece(game_won.board, 0) }

        expect(game_won.winner).to be_truthy
      end
    end
  end
end

describe Player do
  describe '#play_piece' do
    subject(:current_player) { described_class.new('One', 'X') }
    let(:board) { instance_double(Board) }

    context 'when a player plays a game piece' do
      it 'sends place_piece to board' do
        column = 0
        symbol = current_player.instance_variable_get(:@piece)

        expect(board).to receive(:place_piece).with(column, symbol)
        current_player.play_piece(board, column)
      end
    end
  end
end

describe Board do
  describe '#place_piece' do
    subject(:board) { described_class.new }
    
    context 'when a player places a piece' do
      it 'inserts a piece on the board array' do
        expect{ board.place_piece(0, 'X') }.to change{ board.spaces }
      end
    end
  end
end