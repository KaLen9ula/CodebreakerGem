# frozen_string_literal: true

require_relative '../spec_requires'

module Codebraker
  RSpec.describe Game do
    let(:game) { described_class.new }
    let(:difficulty) { :easy }

    before(:each) do
       game.instance_variable_set(:@difficulty, difficulty)
       game.start 
    end

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
