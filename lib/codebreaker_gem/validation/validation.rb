# frozen_string_literal: true

require_relative 'errors_include'

module Validation
  def validate_name(name)
    raise LengthError unless (3..20).cover?(name.length)
  end

  def validate_guess(code)
    raise InputError unless /^[1-6]{4}$/.match?(code)
  end

  def ckeck_for_hints?(hints)
    hints < DIFFICULTIES.values[difficulty][:hints]
  end

  def ckeck_for_attempts?(attempts)
    attempts < DIFFICULTIES.values[difficulty][:attempts]
  end
end
