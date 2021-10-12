# frozen_string_literal: true

require_relative '../spec_requires'

module Codebreaker
  RSpec.describe Game do
    before { stub_const('CodebreakerGem::Game::DIFFICULTIES', { difficulty => { attempts: 1, hints: 1 } }) }

    let(:game) { Game.new }
    let(:difficulty) { :easy }

    before(:each) do
      game.start
      game.difficulty = difficulty
    end

    describe '#available_attempts' do
      it 'returns 1 if attempt is not used' do
        expect(game.user.attempts).eql? 1 
      end

      it 'returns true if attempt was not used' do
        expect(game.check_for_attempts?).to be_truthy
      end

      # it 'returns false if attempt was used' do
      #   game.generate_signs('1111')
      #   game.use_hint
      #   expect(game.check_for_attempts?).to be_falsy
      # end
    end
  end
end
