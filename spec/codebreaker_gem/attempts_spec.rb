# frozen_string_literal: true

require_relative '../spec_requires'

module Codebreaker
  RSpec.shared_examples 'callable attempts' do
    before { stub_const('CodebreakerGem::Game::DIFFICULTIES', { difficulty => { attempts: 1, hints: 1 } }) }

    let(:game) { Game.new }

    before do
      game.start
      game.difficulty = difficulty
    end

    describe '#available_attempts' do
      it 'returns true if attempt is not used' do
        expect(game).to be_ckeck_for_attempts
      end

      it 'returns false if all attempts are used' do
        game.generate_signs('1234')
        expect(game).not_to be_ckeck_for_attempts
      end
    end
  end
end
