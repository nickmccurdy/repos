require 'spec_helper'

describe Findrepos do
  describe '.VERSION' do
    it 'exists' do
      expect(Findrepos::VERSION).not_to be nil
    end
  end

  describe '.clean?' do
    before :example do
      Dir.mkdir 'repo'
      Dir.chdir 'repo' do
        `git init`
        `git config user.name "Example"`
        `git config user.email "example@example.com"`

        FileUtils.touch 'file'
        `git add file`
        `git commit -m "Initial commit."`
      end
    end

    after :example do
      FileUtils.rm_r 'repo'
    end

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
