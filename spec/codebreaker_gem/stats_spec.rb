# frozen_string_literal: true

require_relative '../spec_requires'

module Codebreaker
  include FileStore

  RSpec.describe Stats do
    describe '#show_stats' do
      File.open(FILE_PATH, 'w') do |f|
        f.write([].to_yaml)
      end
      [['name1', 4, 1, :easy], ['name2', 3, 0, :medium],
       ['name3', 4, 1, :hell]].each do |name, attempts, hints, difficulty|
        test_game = Game.new
        test_game.difficulty = difficulty
        test_game.user.name = name
        test_game.user.attempts = attempts
        test_game.user.hints = hints
        Class.new.extend(FileStore).save_file(test_game)
      end

      expected_values = [
        {number: 1, name: 'name3', difficulty: 2, available_attempts: 5, used_attempts: 4, available_hints: 1, used_hints: 1}, 
        {number: 2, name: 'name2', difficulty: 1, available_attempts: 10, used_attempts: 3, available_hints: 1, used_hints: 0}, 
        {number: 3, name: 'name1', difficulty: 0, available_attempts: 15, used_attempts: 4, available_hints: 2, used_hints: 1}
      ]

      it 'returns stats' do
        expect(Class.new.extend(Stats).show_stats).to eq expected_values
      end

      it 'reutrns array' do
        expect(Class.new.extend(Stats).show_stats.class).to eq(Array)
      end
    end
  end
end
