# frozen_string_literal: true

module CodebreakerGem
  module Stats
    def self.show_stats(games)
      games = games.sort_by(&:hints).sort_by(&:attempts).sort_by { |game| -game.difficulty }
      group_statistics(games)
    end

    def self.get_total_results(games)
      games.group_by(&:name).transform_values do |grouped_games|
        { attemts: grouped_games.collect(&:attempts).sum, hints: grouped_games.collect(&:hints).sum }
      end
    end

    def self.group_statistics(games)
      total_results = get_total_results(games)
      games.map.with_index do |game, index, name = game.name|
        [index + 1, name, game.difficulty, total_results[name][:attemts], game.attempts,
         total_results[name][:hints], game.hints]
      end
    end
  end
end
