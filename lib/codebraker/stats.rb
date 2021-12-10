# frozen_string_literal: true

require_relative 'autoloader'

module Codebraker
  class Statistics
    include FileStore

    def show
      load_file&.each&.sort_by { |game| [game[:available_attempts], game[:used_hints], game[:used_attempts]] }
    end
  end
end
