module Codebreaker
  module FileStore
    attr_reader :file_path

    FILE_PATH = 'stats/'.freeze
    FILE_NAME = 'stats.yml'.freeze

    def save_file(game)
      raise WrongStageError unless game.stage == Settings::WIN

      rating = load_file
      rating << game_data(game)
      store = YAML::Store.new(FILE_PATH + FILE_NAME)
      store.transaction do
        store[:codebreakers] = rating
      end
      store
    end

    def load_file
      create_directory(FILE_PATH) unless Dir.exist?(FILE_PATH)
      YAML.load_file(FILE_PATH + FILE_NAME)[:codebreakers] || []
    rescue Errno::ENOENT
      []
    end

    private

    def create_directory(path)
      Dir.mkdir(path)
    rescue Errno::EEXIST
      []
    end

    def game_data(game)
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
