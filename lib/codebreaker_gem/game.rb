# frozen_string_literal: true

require_relative 'validation/validation'
require_relative 'validation/errors_include'

module CodebreakerGem
  class Game
    include Validation
    attr_accessor :name, :code, :difficulty, :attempts, :hints, :available_hints

    CODE_RANGE = (1..6).to_a.freeze
    CODE_LENGTH = 4
    USER_NAME = ''
    GAME_CODE = ''
    GAME_DIFFICULTY = 0
    GAME_ATTEMPTS = 0
    GAME_HINTS = 0
    DIFFICULTIES = {
      easy: { attempts: 15, hints: 2 },
      medium: { attempts: 10, hints: 1 },
      hell: { attempts: 5, hints: 1 }
    }.freeze

    def initialize
      @name = USER_NAME
      @code = GAME_CODE
      @difficulty = GAME_DIFFICULTY
      @attempts = GAME_ATTEMPTS
      @hints = GAME_HINTS
    end

    def start
      @code = CODE_RANGE.sample(CODE_LENGTH).join
      @available_hints = @code.dup
    end

    def use_hint
      return ' ' if @available_hints.empty?

      hint = @available_hints.chars.sample
      @available_hints.sub!(hint, '')
      @hints += 1
      hint
    end

    def difficulty=(difficulty)
      @difficulty = DIFFICULTIES.keys.index(difficulty)
    end

    def name=(name)
      validate_name(name)
      @name = name
    end

    def generate_signs(input_value)
      validate_guess(input_value)
      @attempts += 1
      display_signs(input_value)
    end

    def ckeck_for_hints?
      @hints < DIFFICULTIES.values[difficulty][:hints]
    end

    def ckeck_for_attempts?
      @attempts < DIFFICULTIES.values[difficulty][:attempts]
    end

    def check_for_difficulties
      DIFFICULTIES
    end

    def check_position(input_value)
      code = ''
      extra_char = ''
      (0...CODE_LENGTH).select { |index| input_value[index] == @code[index] }.reverse_each do |index|
        code += '+'
        extra_char += input_value.slice!(index)
      end
      [input_value, code, extra_char]
    end

    def check_inclusion(input_value, code = '', extra_char = '')
      input_value.each_char do |char|
        if @code.include?(char) && !extra_char.include?(char)
          code += '-'
          extra_char += char
        end
      end
      [input_value, code, extra_char]
    end

    def display_signs(input_value)
      input_value, code, extra_char = check_position(input_value)
      _, code, = check_inclusion(input_value, code, extra_char)
      code
    end
  end
end
