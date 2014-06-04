require 'spec_helper'

describe Findrepos do
  before :context do
    Dir.mkdir 'repos'
    Dir.chdir 'repos' do
      Dir.mkdir 'a_repo'
      Dir.chdir('a_repo') { `git init` }

      Dir.mkdir 'not_a_repo'

      Dir.mkdir 'repo_inside'
      Dir.chdir 'repo_inside' do
        Dir.mkdir 'another_repo'
        Dir.chdir('another_repo') { `git init` }
      end
    end
  end

  after :context do
    FileUtils.rm_r 'repos'
  end

  describe '.VERSION' do
    it 'exists' do
      expect(Findrepos::VERSION).not_to be nil
    end
  end

  describe '.clean?' do
    context 'when the given repo has an untracked file' do
      it 'returns false'
    end
    context 'when the given repo has a modified file in the working tree' do
      it 'returns false'
    end
    context 'when the given repo has a modified file in the stage' do
      it 'returns false'
    end
    context 'when the given repo has neither uncommitted changes nor untracked files' do
      it 'returns true'
    end
    context 'when the given repo has no commits' do
      it 'has tests'
    end
  end

  describe '.list' do
    context 'without recursion' do
      it 'lists all Git repositories in the current directory' do
        Dir.chdir 'repos' do
          expect(Findrepos.list).to eq ['a_repo']
        end
      end
    end
    context 'with recursion' do
      it 'lists all Git repositories in the current directory and all ' \
         'subdirectories' do
        Dir.chdir 'repos' do
          expect(Findrepos.list recursive: true).to eq ['a_repo', 'repo_inside/another_repo']
        end
      end
    end
  end
end
