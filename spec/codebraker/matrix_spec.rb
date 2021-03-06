require_relative '../spec_requires'

module Codebraker
  RSpec.describe Game do
    let(:game) { Game.new }
    let(:difficulty) { :easy }

    before(:each) do
       game.instance_variable_set(:@difficulty, difficulty)
       game.start 
    end

    describe '#generate_sings' do
      matrix = 
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

      it 'decreases attempts by 1' do
        expect { game.generate_signs('1111') }.to change(game.user, :attempts).by(-1)
      end

      matrix.each do |code, guess, expected|
        it "returnes #{expected} when generated code is #{code} and guessed by user code is #{guess}" do
          game.instance_variable_set(:@code, code)
          expect(game.generate_signs(guess)).to eq expected
        end
      end
    end
  end
end
