# frozen_string_literal: true

require_relative 'file_store'

module Codebreaker
  module Stats
    include FileStore

    def show_stats
      data = load_file
      data.sort_by! { |game| [Settings::DIFFICULTIES[game.difficulty][:attempts], game.user.hints, game.user.attempts] }
      group_statistics(data)
    end

    private

    def group_statistics(data)
      data_array = []
      data.each_with_index do |game, index, name = game.user.name|
        stats_group = {}
        stats_group[:number] = index + 1
        stats_group[:name] = name
        stats_group[:difficulty] = game.difficulty
        stats_group[:available_attempts] = Settings::DIFFICULTIES[game.difficulty][:attempts]
        stats_group[:used_attempts] = game.user.attempts
        stats_group[:available_hints] = Settings::DIFFICULTIES[game.difficulty][:hints]
        stats_group[:used_hints] = game.user.hints
        data_array << stats_group
      end
      data_array
    end
  end
end
