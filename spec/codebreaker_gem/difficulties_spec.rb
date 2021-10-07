# frozen_string_literal: true

require_relative '../spec_requires'

module Codebreaker
  RSpec.describe Game do
    let(:game) { described_class.new }

    before { game.start }

    describe '#available_difficulties' do
      it 'returns hash' do
        expect(game.check_for_difficulties.class).to eq(Hash)
      end

      it 'returns available difficulties' do
        expect(game.check_for_difficulties).to eq(Game::DIFFICULTIES)
      end
    end
  end
end