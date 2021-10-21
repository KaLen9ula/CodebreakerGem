# frozen_string_literal: true

class InputError < StandardError
  def initialize
    super(I18n.t('error.input_error'))
  end
end
