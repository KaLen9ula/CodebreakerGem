require 'yaml'

require_relative 'validation/errors/stage_error'

module Codebreaker
  module FileStore
    attr_reader :file_path

    FILE_PATH = 'stats/stats.yml'.freeze

    def save_file(game)
      raise WrongStageError unless game.stage == Settings::WIN

      rating = load_file
      rating << game_data(game)
      File.open(FILE_PATH, 'w') do |f|
        f.write(rating.to_yaml)
      end
    end

    def load_file
      YAML.load_file(FILE_PATH) || []
    rescue Errno::ENOENT
      []
    end

    private

    def game_data(game)
      game_hash = {}
      game_hash[:difficulty] = game.difficulty
      game_hash[:available_attempts] = Settings::DIFFICULTIES[game.difficulty][:attempts]
      game_hash[:available_hints] = Settings::DIFFICULTIES[game.difficulty][:hints]
      game_hash.merge(fetch_user_data(game))
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
