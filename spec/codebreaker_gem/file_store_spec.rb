# frozen_string_literal: true

require_relative '../spec_requires'

module Codebreaker
    RSpec.describe FileStore do
        let(:test_class) { Class.new { include FileStore }.new }
        let(:user) { double(User, name: 'player1', hints: 2, attempts: 15) }
        let(:game) { double(Game, user: user, difficulty: :easy, stage: Settings::WIN) }
        
        before do
            File.open('stats/test.yml', 'w') do |f|
                f.write([].to_yaml)
            end
            stub_const('Codebreaker::FileStore::FILE_PATH', 'stats/test.yml')
        end

        describe '#load_file' do
            it 'returns true when file is empty' do
                expect(test_class.load_file).to eq []
            end
        end

        describe '#save_file' do
            it 'returns true when file is not empty' do
                expect { test_class.save_file(game) }.to change { test_class.load_file.size }.by(1)
            end
        end
    end
end
