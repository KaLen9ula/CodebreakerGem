# frozen_string_literal: true

require_relative '../spec_requires'

module CodebreakerGem
  RSpec.describe Validation do
    let(:test_name) { Class.new { extend Validation } }

    context '#validate_name' do
      it 'raise LengthError if name has less than 3 letters' do
        expect { test_name.validate_name('Mo') }.to raise_error LengthError
      end

      it 'raise LengthError if name has more than 20 letters' do
        expect { test_name.validate_name('Luvsanperenleizhangtsan') }.to raise_error LengthError
      end
    end
  end
end
