require_relative 'game_config'

module Codebreaker
  include Settings

  module CodeMatcher
    def check_position(input_value)
      code = ''
      extra_char = ''
      (0...Codebreaker::CODE_LENGTH).select { |index| input_value[index] == @code[index] }.reverse_each do |index|
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
  end
end
