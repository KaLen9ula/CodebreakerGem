# frozen_string_literal: true

require_relative '../spec_requires'

module Codebraker
  RSpec.describe Validation do
    let(:test_guess) { Class.new { extend Validation } }

    describe '#validate_guess' do
      it 'raise InputError if guess has more than 4 numbers' do
        expect { test_guess.validate_guess('12345') }.to raise_error InputError
      end

      it 'raise InputError if guess has less than 4 numbers' do
        expect { test_guess.validate_guess('123') }.to raise_error InputError
      end

      it 'raise InputError if guess has number with 7 or more' do
        expect { test_guess.validate_guess('7645') }.to raise_error InputError
      end

      it 'raise InputError if guess has number 0' do
        expect { test_guess.validate_guess('0512') }.to raise_error InputError
      end

      it 'raise InputError if guess has unidentified symbol' do
        expect { test_guess.validate_guess('0s12') }.to raise_error InputError
      end
    end
  end
end
