require_relative '../spec_requires'

module Codebreaker
  RSpec.describe Game do
    let(:game) { described_class.new }

    before { game.start }

    describe '#hint' do
      it 'hint is available' do
        expect(game.instance_variable_get(:@code)).to include game.use_hint
      end

      it 'returns nothing when all hints are used' do
        game.available_hints = '1'
        game.use_hint

        expect(game.use_hint).to eq ' '
      end
    end
  end
end