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
    context 'when there are four of the same pieces in a row' do
      subject(:game_won) { described_class.new }

      it 'returns true' do
        winner = Player.new('One', 'X')
        4.times {|i| winner.play_piece(game_won.board, i) }
        expect(game_won.check_winner).to eq(true)
      end
    end

    context 'when there are not four pieces in a row' do
      subject(:ongoing_game) { described_class.new }
      it 'returns false' do
        expect(ongoing_game.check_winner).to eq(false)
      end
    end
  end

  describe '#check_rows' do
    context 'when there are four of the same pieces in a horizontal row' do
      subject(:row_won) { described_class.new }

      it 'returns true' do
        winner = Player.new('One', 'O')
        4.times {|i| winner.play_piece(row_won.board, i) }
        expect(row_won.check_rows).to eq(true)
        row_won.check_rows
      end
    end
  end

  describe '#check_columns' do
    context 'when there are four of the same pieces in a vertical row' do
      subject(:column_won) { described_class.new }

      it 'returns true' do
        winner = Player.new('One', 'X')
        4.times { winner.play_piece(column_won.board, 0) }
        expect(column_won.check_columns).to eq(true)
        column_won.check_columns
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