# frozen_string_literal: true

require_relative 'file_store'

module Codebreaker
  module Stats
    include FileStore

    def show_stats
      data = load_file
      data.sort_by! { |game| [game[:available_attempts], game[:used_hints], game[:used_attempts]] }
    end
  end
end
