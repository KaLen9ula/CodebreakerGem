# frozen_string_literal: true

require_relative 'data_sort'

module Codebraker
  module FileStore
    include DataSort

    FILE_DIRECTORY = 'stats'
    FILE_NAME = 'stats.yml'

    def save_file(game)
      raise WrongStageError unless game.stage == Settings::WIN

      rating = load_file
      rating << fetch_game_data(game)
      store = YAML::Store.new(storage_path)
      store.transaction do
        store[:codebrakers] = rating
      end
      store
    end

    def load_file
      create_storage unless storage_exists?
      (YAML.load_file(storage_path) || {})[:codebrakers]
    end

    def create_storage
      Dir.mkdir(FILE_DIRECTORY) unless Dir.exist?(FILE_DIRECTORY)
      File.open(storage_path, 'w+') unless File.exist?(storage_path)
      YAML.load_file(storage_path)
    end

    private

    def storage_path
      File.join(FILE_DIRECTORY, FILE_NAME)
    end

    def storage_exists?
      Dir.exist?(FILE_DIRECTORY) && File.exist?(storage_path)
    end
  end
end
