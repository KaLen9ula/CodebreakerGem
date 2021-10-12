require 'yaml'

require_relative 'validation/errors/stage_error'

module Codebreaker
  module FileStore
    attr_reader :file_path

    FILE_PATH = 'stats/stats.yml'.freeze

    def save_file(game)
      raise WrongStageError unless game.stage == Settings::WIN
      rating = load_file
      rating << game
      File.open(FILE_PATH, 'w') do |f|
        f.write(rating.to_yaml)
      end
    end

    def load_file
      YAML.load_file(FILE_PATH) || []
    rescue Errno::ENOENT
      []
    end
  end
end
