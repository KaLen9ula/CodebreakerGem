require_relative '../spec_requires'

module Codebraker
  RSpec.describe Game do
    before { stub_const('Codebraker::Game::DIFFICULTIES', { difficulty => { attempts: 1, hints: 1 } }) }

    let(:game) { described_class.new }
    let(:difficulty) { :easy }

    before(:each) do
      game.start
      game.instance_variable_set(:@difficulty, difficulty)
    end 

    describe '#hint' do
      it 'hint is available' do
        expect(game.instance_variable_get(:@code)).to include game.use_hint
      end

      it 'returns 1 if hint was not used' do
        game.user.hints = 1
        expect(game.check_for_hints?).to be_truthy
      end

      it 'returns 0 when all hints are used' do
        game.user.hints = 1
        game.use_hint

        expect(game.user.hints).to eq 0
      end
    end
  end
end
