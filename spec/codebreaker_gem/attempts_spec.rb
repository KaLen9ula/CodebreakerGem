# frozen_string_literal: true

require_relative '../spec_requires'

module CodebreakerGem
  RSpec.shared_examples 'callable attempts' do
    before { stub_const('CodebreakerGem::Game::DIFFICULTIES', { difficulty => { attempts: 1, hints: 1 } }) }
    let(:game) { Game.new }
    before(:each) do
      game.start
      game.difficulty = difficulty
    end

    context '#available_attempts' do
      it 'returns true if attempt is not used' do
        expect(game.ckeck_for_attempts?).to be_truthy
      end

      it 'returns false if all attempts are used' do
        game.generate_signs('1234')
        # binding.pry
        expect(game.ckeck_for_attempts?).to be_falsey
      end
    end
  end
end
