# frozen_string_literal: true

class LengthError < StandardError
  def initialize
    super('Incorrect length')
  end
end
