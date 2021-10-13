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

    attr_accessor :code, :user, :available_hints, :stage, :difficulty

    def initialize(code: GAME_CODE, user: User.new, stage: START_GAME, difficulty: DIFFICULTIES)
      @code = code
      @user = user
      @stage = stage
      @difficulty = difficulty
    end

    def start
      raise WrongStageError unless @stage == START_GAME

      @code = CODE_RANGE.sample(CODE_LENGTH).join
      @available_hints = @code.dup
      @stage = IN_GAME
    end

    def generate_signs(input_value)
      raise WrongStageError unless @stage == IN_GAME

      validate_guess(input_value)
      user.attempts -= ATTEMPTS_INCREMENT
      display_signs(input_value)
    end

    def assign_difficulty(input)
      return unless DIFFICULTIES.include?(input.to_sym)

      user.attempts = DIFFICULTIES[input.to_sym][:attempts]
      user.hints = DIFFICULTIES[input.to_sym][:hints]
    end

    def use_hint
      return if @available_hints.empty?

      hint = @available_hints.chars.sample
      @available_hints.sub!(hint, '')
      user.hints -= HINTS_DECREMENT
      hint
    end

    def check_for_hints?
      (user.hints < DIFFICULTIES[@difficulty][:hints]) && user.hints.positive?
    end

    def check_for_attempts?
      (user.attempts < DIFFICULTIES[@difficulty][:attempts]) && user.attempts.positive?
    end

    def win?(result)
      result == @code
    end

    def lose?
      user.attempts.zero?
    end

    def check_for_difficulties
      DIFFICULTIES
    end

    def end_game(guess)
      raise WrongStageError unless @stage == IN_GAME

      if win?(guess)
        @stage = WIN
      elsif lose?
        @stage = LOSE
      end
      @stage
    end

    def display_signs(input_value)
      input_value, code, extra_char = check_position(input_value)
      _input_value, code, _extra_char = check_inclusion(input_value, code, extra_char)
      code
    end
  end
end
