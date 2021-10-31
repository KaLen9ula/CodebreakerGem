# frozen_string_literal: true

require_relative '../spec_requires'

module Codebraker
  RSpec.describe FileStore do
    let(:test_class) { Class.new { include FileStore }.new }
    let(:user) { double(User, name: 'player1', hints: 2, attempts: 15) }
    let(:game) { double(Game, user: user, difficulty: :easy, stage: Settings::WIN) }

    describe '#load_file' do
      before do
        stub_const('Codebraker::FileStore::FILE_NAME', 'test_1.yml')
        stub_const('Codebraker::FileStore::FILE_DIRECTORY', 'spec/fixtures')
      end
      
      it 'returns true when file is empty' do
        expect(test_class.create_storage).to eq({codebrakers: []})
      end
    end

    describe '#save_file' do
      before do
        stub_const('Codebraker::FileStore::FILE_NAME', 'test.yml')
        stub_const('Codebraker::FileStore::FILE_DIRECTORY', 'spec/fixtures')
      end
      
      it 'returns true when file is not empty' do
        expect(test_class.load_file.size).to eq 1
      end
    end

    describe '#save_file' do
      let(:expected_values) {[
        {:available_attempts=>15, :available_hints=>2, :difficulty=>:easy, :name=>"player1", :used_attempts=>0, :used_hints=>0}
      ]}

      before do
        stub_const('Codebraker::FileStore::FILE_NAME', 'test_3.yml')
        stub_const('Codebraker::FileStore::FILE_DIRECTORY', 'spec/fixtures')
      end

      after do
        File.delete(FileStore::FILE_DIRECTORY + '/' + FileStore::FILE_NAME) if File.exist?(FileStore::FILE_DIRECTORY + '/' + FileStore::FILE_NAME)
      end

      it 'creates file, puts data inside and deletes file' do
        test_class.save_file(game)
        expect(test_class.load_file).to eq(expected_values)
      end
    end
  end
end
