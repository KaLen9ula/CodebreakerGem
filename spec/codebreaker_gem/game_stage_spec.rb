# frozen_string_literal: true

require_relative '../spec_requires'

module Codebreaker
    RSpec.describe Game do
        let(:game) { Game.new }
        let(:test_class) { Class.new { include FileStore }.new }

        before { game.stage = Settings::LOSE }
        
        context 'wrong stage error' do
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
    end
end
