# frozen_string_literal: true

require 'i18n'
I18n.load_path << Dir[['config', 'locales', '**', '*.yml'].join('/')]
I18n.config.available_locales = :en, :ru

require_relative 'validation/validation'
require_relative 'validation/errors_include'
require_relative 'matrix_matcher'
require_relative 'game_config'
require_relative 'user'

module Codebreaker
  class Game
    include Validation
    include CodeMatcher
    include Settings

    attr_accessor :code, :user, :available_hints
    attr_reader :difficulty

    def initialize(code: GAME_CODE, user: User.new)
      @code = code
      @user = user
    end

    def start
      @code = CODE_RANGE.sample(CODE_LENGTH).join
      @available_hints = @code.dup
    end

    def difficulty=(difficulty)
      @difficulty = DIFFICULTIES.keys.index(difficulty)
    end

    def generate_signs(input_value)
      validate_guess(input_value)
      user.attempts += ATTEMPTS_INCREMENT
      display_signs(input_value)
    end

    def use_hint
      return if @available_hints.empty?

      hint = @available_hints.chars.sample
      @available_hints.sub!(hint, '')
      user.hints -= HINTS_INCREMENT
      hint
    end

    def check_for_difficulties
      DIFFICULTIES
    end

    def display_signs(input_value)
      input_value, code, extra_char = check_position(input_value)
      _input_value, code, _extra_char = check_inclusion(input_value, code, extra_char)
      code
    end
  end
end
