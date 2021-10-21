require_relative '../spec_requires'

module Codebraker
  RSpec.describe Game do
    let(:game) { Game.new }

    before do 
      game.start
      game.instance_variable_set(:@code, '3142')
    end

    describe '#start' do
      it 'generates code' do
        expect(game.instance_variable_get(:@code)).not_to be_empty
      end

      it 'code is 4 digit' do
        expect(game.instance_variable_get(:@code).size).to eq Game::CODE_LENGTH
      end

      it 'code is number with 1 to 6 digits' do
        expect(game.instance_variable_get(:@code)).to match(/[1-6]+/)
      end
    end

    context 'end of game' do
      it 'returns true if the guess is right' do
        expect(game.win?('3142')).to be_truthy
      end

      it 'returns false if the guess us wrong' do
        expect(game.win?('3214')).to be_falsy
      end

      it 'returns false if player has not lost' do
        game.user.attempts = 1
        expect(game.lose?).to be_falsy
      end

      it 'returns true if player has lost' do
        game.user.attempts = 0
        expect(game.lose?).to be_truthy
      end
    end
  end
end
