# frozen_string_literal: true

require 'i18n'
I18n.load_path << Dir[['config', 'locales', '**', '*.yml'].join('/')]
I18n.config.available_locales = :en, :ru

require_relative 'autoloader'

module Codebraker
  class Game
    include Validation
    include CodeMatcher
    include Settings
    include FileStore
    include Stats

    attr_accessor :difficulty
    attr_reader :possible_hints, :code, :user, :stage

    def initialize(code: '', user: User.new, stage: START_GAME, difficulty: DIFFICULTIES)
      @code = code
      @user = user
      @stage = stage
      @difficulty = difficulty
    end

    def start
      raise WrongStageError unless @stage == START_GAME

      @code = CODE_RANGE.sample(CODE_LENGTH).join
      @possible_hints = @code.dup
      assign_difficulty
      @stage = IN_GAME
    end

    def generate_signs(input_value)
      raise WrongStageError unless @stage == IN_GAME

      validate_guess(input_value)
      user.attempts -= ATTEMPTS_DECREMENT
      display_signs(input_value)
    end

    def assign_difficulty
      user.attempts = DIFFICULTIES[@difficulty][:attempts]
      user.hints = DIFFICULTIES[@difficulty][:hints]
    end

    def use_hint
      return if @possible_hints.empty?

      hint = @possible_hints.chars.sample
      @possible_hints.sub!(hint, '')
      user.hints -= HINTS_DECREMENT
      hint
    end

    def check_for_hints?
      (user.hints <= DIFFICULTIES[@difficulty][:hints]) && user.hints.positive?
    end

    def check_for_attempts?
      (user.attempts < DIFFICULTIES[@difficulty][:attempts]) && user.attempts.positive?
    end

    def win?(result)
      return unless result == @code

      @stage = WIN
      true
    end

    def lose?
      return unless user.attempts.zero?

      @stage = LOSE
      true
    end

    def check_for_difficulties
      DIFFICULTIES
    end

    def save_game(game)
      save_file(game)
    end

    def show_statistics
      show_stats
    end

    def display_signs(input_value)
      input_value, code, extra_char = check_position(input_value)
      _input_value, code, _extra_char = check_inclusion(input_value, code, extra_char)
      code
    end
  end
end
