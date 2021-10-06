# frozen_string_literal: true

require_relative '../spec_requires'

module CodebreakerGem
  RSpec.describe Game do
    let(:game) { Game.new }
    before do
      game.start
    end

    context '#available_difficulties' do
      it 'returns hash' do
        expect(game.check_for_difficulties.class).to eq(Hash)
      end

      it 'returns available difficulties' do
        expect(game.check_for_difficulties).to eq(Game::DIFFICULTIES)
      end
    end
  end
end
