# frozen_string_literal: true

class WrongStageError < StandardError
    def initialize
      super(I18n.t('error.stage_error'))
    end
  end
