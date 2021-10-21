# frozen_string_literal: true

class LengthError < StandardError
  def initialize
    super(I18n.t('error.length_error'))
  end
end
