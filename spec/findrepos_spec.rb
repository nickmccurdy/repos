require 'spec_helper'

describe Findrepos do
  describe '.VERSION' do
    it 'exists' do
      expect(Findrepos::VERSION).not_to be nil
    end
  end

  describe '.clean?' do
    before(:example) { create_repo 'repo' }

    after(:example) { FileUtils.rm_r 'repo' }

    context 'when the given repo has an untracked file' do
      it 'returns false' do
        Dir.chdir('repo') { FileUtils.touch 'README' }
        expect(Findrepos.clean? 'repo').to be false
      end
    end

    context 'when the given repo has a modified file in the working tree' do
      it 'returns false' do
        Dir.chdir('repo') { `echo "hello" > file` }
        expect(Findrepos.clean? 'repo').to be false
      end
    end

    context 'when the given repo has a modified file in the stage' do
      it 'returns false' do
        Dir.chdir 'repo' do
          `echo "hello" > file`
          `git add file`
        end
        expect(Findrepos.clean? 'repo').to be false
      end
    end

    context 'when the given repo has neither uncommitted changes nor ' \
            'untracked files' do
      it 'returns true' do
        expect(Findrepos.clean? 'repo').to be true
      end
    end

    context 'when the given repo has no commits' do
      it 'has tests'
    end
  end

  describe '.list' do
    before :context do
      Dir.mkdir 'repos'
      Dir.chdir 'repos' do
        create_repo 'a_repo'

        Dir.mkdir 'not_a_repo'

        Dir.mkdir 'repo_inside'
        Dir.chdir('repo_inside') { create_repo 'another_repo' }
      end
    end

    after :context do
      FileUtils.rm_r 'repos'
    end

    context 'without recursion' do
      it 'lists all Git repositories in the current directory' do
        expect(Findrepos.list 'repos').to eq ['repos/a_repo']
      end
    end

    context 'with recursion' do
      it 'lists all Git repositories in the current directory and all ' \
         'subdirectories' do
        expect(Findrepos.list('repos', true)).to \
          contain_exactly('repos/a_repo', 'repos/repo_inside/another_repo')
      end
    end
  end
end
