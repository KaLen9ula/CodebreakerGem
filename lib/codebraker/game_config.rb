# frozen_string_literal: true

module Codebraker
  module Settings
    CODE_RANGE = (1..6).to_a.freeze
    CODE_LENGTH = 4
    CODE_NUMBERS = /^[1-6]{4}$/.freeze
    NAME_LENGTH = (3..20).freeze
    PLUS = '+'
    MINUS = '-'
    GAME_ATTEMPTS = 0
    GAME_HINTS = 0
    HINTS_DECREMENT = 1
    ATTEMPTS_DECREMENT = 1
    START_GAME = :start
    IN_GAME = :game
    WIN = :win
    LOSE = :lose
    DIFFICULTIES = {
      easy: { attempts: 15, hints: 2 },
      medium: { attempts: 10, hints: 1 },
      hell: { attempts: 5, hints: 1 }
    }.freeze
  end
end
