# frozen_string_literal: true

require_relative 'autoloader'

module Codebraker
  include Settings

  module CodeMatcher
    def check_position(input_value)
      code = ''
      extra_char = ''
      code_selector(input_value).reverse_each do |index|
        code += '+'
        extra_char += input_value.slice(index)
      end
      [input_value, code, extra_char]
    end

    def check_inclusion(input_value, code = '', extra_char = '')
      input_value.each_char do |char|
        if char_inclusion?(char, extra_char)
          code += '-'
          extra_char += char
        end
      end
      [input_value, code, extra_char]
    end

    private

    def code_selector(input_value)
      (0...Codebraker::CODE_LENGTH).select { |index| input_value[index] == @code[index] }
    end

    def char_inclusion?(char, extra_char)
      @code.include?(char) && !extra_char.include?(char)
    end
  end
end
