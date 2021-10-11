# frozen_string_literal: true

require_relative 'file_store'

module Codebreaker
  module Stats
    include FileStore

    def show_stats
      data = load_file || []
      data.sort_by! { |game| [-game.difficulty, game.user.hints, game.user.attempts] }
      group_statistics(data)
    end

    private

    def group_statistics(data)
      data.map.with_index do |game, index, name = game.user.name|
        {number: index + 1, name: name, difficulty: game.difficulty,
         available_attempts: Settings::DIFFICULTIES[Settings::DIFFICULTIES.keys[game.difficulty]][:attempts], used_attempts: game.user.attempts,
         available_hints: Settings::DIFFICULTIES[Settings::DIFFICULTIES.keys[game.difficulty]][:hints], used_hints: game.user.hints}
      end
    end
  end
end
