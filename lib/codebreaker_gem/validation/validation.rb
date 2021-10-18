# frozen_string_literal: true

require_relative '../game_config'
require_relative 'errors_include'

module Codebreaker
  module Validation
    include Settings

    def validate_name(name)
      raise LengthError unless NAME_LENGTH.cover?(name.length)
    end

    def validate_guess(code)
      raise InputError unless CODE_NUMBERS.match?(code)
    end
  end
end
