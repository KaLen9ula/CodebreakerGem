# frozen_string_literal: true

require_relative '../spec_requires'

module CodebreakerGem
  RSpec.describe Stats do
    context '#show_stats' do
      it 'returns stats' do
        test_games = []
        [['name1', 4, 1, :easy], ['name1', 3, 0, :medium],
         ['name1', 4, 1, :hell]].each do |name, attempts, hints, difficulty|
          test_game = Game.new
          test_game.difficulty = difficulty
          test_game.name = name
          test_game.attempts = attempts
          test_game.hints = hints
          test_games << test_game
        end

        expected_values = [
          [1, 'name1', 2, 11, 4, 2, 1], [2, 'name1', 1, 11, 3, 2, 0], [3, 'name1', 0, 11, 4, 2, 1]
        ]
        expect(Stats.show_stats(test_games)).to eq expected_values
      end
    end
  end
end
