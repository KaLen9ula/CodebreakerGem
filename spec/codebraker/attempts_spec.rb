require_relative '../spec_requires'

module Codebraker
  RSpec.describe Game do
    before { stub_const('CodebreakerGem::Game::DIFFICULTIES', { difficulty => { attempts: 1, hints: 1 } }) }

    let(:game) { Game.new }
    let(:difficulty) { :easy }

    before(:each) do
      game.instance_variable_set(:@difficulty, difficulty)
      game.start
    end

    describe '#available_attempts' do
      it 'returns 1 if attempt is not used' do
        expect(game.user.attempts).eql? 1 
      end

      it 'returns true if attempt was not used' do
        game.user.attempts = 1
        expect(game.check_for_attempts?).to be_truthy
      end

      it 'returns false if attempts were used' do
        game.user.attempts = 1
        game.generate_signs('1111')
        expect(game.check_for_attempts?).to be_falsy
      end
    end
  end
end
