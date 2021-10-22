# frozen_string_literal: true

require_relative 'data_sort'
require 'pry'

module Codebraker
  module FileStore
    include DataSort

    FILE_DIRECTORY = 'stats'
    FILE_NAME = 'stats.yml'

    def save_file(game)
      raise WrongStageError unless game.stage == Settings::WIN

      rating = storage_exists? ? load_file : create_storage[:codebrakers]
      rating << fetch_game_data(game)
      store = YAML::Store.new(storage_path)
      store.transaction do
        store[:codebrakers] = rating
      end
      store
    end

    def load_file
      YAML.load_file(storage_path)[:codebrakers]
    end

    def create_storage
      Dir.mkdir(FILE_DIRECTORY) unless Dir.exist?(FILE_DIRECTORY)
      unless File.exist?(storage_path)
        new_file = YAML::Store.new(storage_path)
        new_file.transaction do
          new_file[:codebrakers] = []
        end
      end
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
