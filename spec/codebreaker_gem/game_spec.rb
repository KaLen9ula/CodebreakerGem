# frozen_string_literal: true

require_relative '../spec_requires'

module CodebreakerGem
  RSpec.describe Game do
    let(:game) { Game.new }
    before do
      game.start
    end

    context '#start' do
      it 'saves code' do
        expect(game.instance_variable_get(:@code)).not_to be_empty
      end

      it 'saves 4 digit code' do
        expect(game.instance_variable_get(:@code).size).to eq Game::CODE_LENGTH
      end

      it 'saves code with 1 to 6 digits' do
        expect(game.instance_variable_get(:@code)).to match(/[1-6]+/)
      end
    end
  end
end
