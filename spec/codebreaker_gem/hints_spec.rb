require_relative '../spec_requires'

module Codebreaker
  RSpec.describe Game do
    before { stub_const('Codebreaker::Game::DIFFICULTIES', { difficulty => { attempts: 1, hints: 1 } }) }

    let(:game) { described_class.new }
    let(:difficulty) { :easy }

    before(:each) do
      game.start
      game.difficulty = difficulty
    end 

    describe '#hint' do
      it 'hint is available' do
        expect(game.instance_variable_get(:@code)).to include game.use_hint
      end

      it 'returns 1 if hint was not used' do
        expect(game.user.attempts).eql? 1
      end

      it 'returns nothing when all hints are used' do
        game.available_hints = '1'
        game.use_hint

        expect(game.use_hint).to eq nil
      end
    end
  end
end
