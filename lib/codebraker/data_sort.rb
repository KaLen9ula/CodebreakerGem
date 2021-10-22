# frozen_string_literal: true

module Codebraker
  module DataSort
    def fetch_game_data(game)
      game_results = {}
      game_results[:difficulty] = game.difficulty
      game_results[:available_attempts] = Settings::DIFFICULTIES[game.difficulty][:attempts]
      game_results[:available_hints] = Settings::DIFFICULTIES[game.difficulty][:hints]
      game_results.merge(fetch_user_data(game))
    end

    def fetch_user_data(game)
      user_data = {}
      user_data[:name] = game.user.name
      user_data[:used_attempts] = game.user.attempts
      user_data[:used_hints] = game.user.hints
      user_data
    end
  end
end
