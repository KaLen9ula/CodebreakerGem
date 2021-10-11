require_relative 'game_config'

module Codebreaker
  class User
    include Validation
    include Settings

    attr_accessor :attempts, :hints
    attr_reader :name

    def initialize(name: USER_NAME, attempts: GAME_ATTEMPTS, hints: GAME_HINTS)
      @name = name
      @attempts = attempts
      @hints = hints
    end

    def name=(name)
      validate_name(name)
      @name = name
    end
  end
end
