require_relative '../spec_requires'
require 'pry'

module Codebreaker
  RSpec.describe Game do
    let(:game) { described_class.new }
    let(:matrix) do
      [
        ['6543', '2222', ''],
        ['2233', '1113', '+'],
        ['6543', '2666', '-'],
        ['6666', '1661', '++'],
        ['3245', '1256', '+-'],
        ['1652', '6143', '--'],
        ['1234', '1235', '+++'],
        ['1234', '1524', '++-'],
        ['6543', '3456', '----'],
        ['1234', '1234', '++++'],
        ['5143', '5413', '++--']
      ]
    end

    before { game.start }

    describe '#generate_sings' do
      it 'increases attempts by 1' do
        expect { game.generate_signs('1111') }.to change(game.user, :attempts).by(1)
      end

      it 'returns sthm' do
        matrix.each do |code, guess, expected|
          game.code = code
          expect(game.generate_signs(guess)).to eq expected
        end
      end
    end
  end
end
