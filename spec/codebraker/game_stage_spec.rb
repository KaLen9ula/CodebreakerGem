require_relative '../spec_requires'

module Codebraker
  RSpec.describe Game do
    let(:game) { Game.new }
    let(:test_class) { Class.new { include FileStore }.new }
        
    context 'wrong stage error' do
      before { game.instance_variable_set(:@stage, Settings::LOSE) }

      it 'raises WrongStageError when user is in inapropriate to start stage' do
        expect { game.start }.to raise_error WrongStageError
      end

      it 'raises WrongStageError when user is in inapropriate to guessing stage' do
        expect { game.generate_signs('1324') }.to raise_error WrongStageError
      end

      it 'raises WrongStageError when user is in inapropriate to saving results stage' do
        expect { test_class.save_file(game) }.to raise_error WrongStageError
      end
    end

    context 'jump to the other stage' do
      it 'jumps from start stage to in game stage' do
        expect { game.start }.to change { game.stage }.from(Settings::START_GAME).to(Settings::IN_GAME)
      end

      it 'jumps from in game stage to winning stage' do
        game.start
        game.instance_variable_set(:@code, '1642')
        expect { game.end_game('1642') }.to change { game.stage }.from(Settings::IN_GAME).to(Settings::WIN)
      end

      it 'jumps from in game stage to losing stage' do
        game.start
        game.instance_variable_set(:@code, '1642')
        expect { game.end_game('1624') }.to change { game.stage }.from(Settings::IN_GAME).to(Settings::LOSE)
      end
    end
  end
end
