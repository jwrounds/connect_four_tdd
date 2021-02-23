require_relative '../lib/connect_four.rb'
require_relative '../lib/connect_four_player.rb'
require_relative '../lib/connect_four_board.rb'

describe Game do
  describe '#game_over?' do
    subject(:game_over) { described_class.new }

    context 'when a player has won' do
      before do
        allow(game_over).to receive(:check_winner).and_return('Player One')
      end
      it 'returns true' do
        expect(game_over).to be_game_over
      end
    end

    context 'when the board is full' do
      before do
        allow(game_over).to receive(:check_full).and_return(true)
      end
      it 'returns true' do
        expect(game_over).to be_game_over
      end
    end
  end

  describe '#check_full' do
    context 'when the board is filled with pieces without four in a row' do
      let(:full_board) { instance_double(Board, spaces: [
        ['X', 'O', 'X', 'O', 'X', 'O', 'X'],
        ['O', 'X', 'O', 'X', 'O', 'X', 'O'],
        ['X', 'O', 'X', 'O', 'X', 'O', 'X'],
        ['X', 'O', 'X', 'O', 'X', 'O', 'X'],
        ['X', 'O', 'X', 'O', 'X', 'O', 'X'],
        ['O', 'X', 'O', 'X', 'O', 'X', 'O']
        ]) }
      subject(:full_game) { described_class.new(full_board) }
      
      it 'returns true' do
        expect(full_game.check_full).to eq(true)
      end
    end

    context 'when the board is not full' do
      subject(:open_game) { described_class.new }

      it 'returns false' do
        expect(open_game.check_full).to eq(false)
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