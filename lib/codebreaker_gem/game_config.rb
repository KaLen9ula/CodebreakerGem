module Codebreaker
  module Settings
    CODE_RANGE = (1..6).to_a.freeze
    CODE_LENGTH = 4
    USER_NAME = ''.freeze
    GAME_CODE = ''.freeze
    GAME_ATTEMPTS = 0
    GAME_HINTS = 0
    HINTS_INCREMENT = 1
    ATTEMPTS_INCREMENT = 1
    DIFFICULTIES = {
      easy: { attempts: 15, hints: 2 },
      medium: { attempts: 10, hints: 1 },
      hell: { attempts: 5, hints: 1 }
    }.freeze
  end
end
