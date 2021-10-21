# frozen_string_literal: true

require_relative 'autoloader'

module Codebraker
  module Stats
    include FileStore

    def show_stats
      load_file.sort_by! { |game| [game[:available_attempts], game[:used_hints], game[:used_attempts]] }
    end
  end
end
