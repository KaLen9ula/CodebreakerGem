# frozen_string_literal: true

require_relative '../spec_requires'

module CodebreakerGem
  RSpec.describe Game do
    let(:game) { Game.new }
    before do
      game.start
    end

    context '#assign_difficulty' do
      it 'easy difficulty is when @difficulty equals 0' do
        game.difficulty = :easy
        expect(game.difficulty).to eq 0
      end

      it 'medium difficulty is when @difficulty equals 1' do
        game.difficulty = :medium
        expect(game.difficulty).to eq 1
      end

      it 'hell difficulty is when @difficulty equals 2' do
        game.difficulty = :hell
        expect(game.difficulty).to eq 2
      end
    end

    context '#assign_name' do
      it 'sets name' do
        name = FFaker::Name.name
        game.name = name
        expect(game.name).to eq name
      end
    end
  end
end
