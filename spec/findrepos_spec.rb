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

    context 'when the given repository has an untracked file' do
      it 'returns false' do
        Dir.chdir('repo') { FileUtils.touch 'README' }
        expect(Findrepos.clean? 'repo').to be false
      end
    end

    context 'when the given repository has a modified file in the working tree' do
      it 'returns false' do
        Dir.chdir('repo') { `echo "hello" > file` }
        expect(Findrepos.clean? 'repo').to be false
      end
    end

    context 'when the given repository has a modified file in the stage' do
      it 'returns false' do
        Dir.chdir 'repo' do
          `echo "hello" > file`
          `git add file`
        end
        expect(Findrepos.clean? 'repo').to be false
      end
    end

    context 'when the given repository has neither uncommitted changes nor ' \
            'untracked files' do
      it 'returns true' do
        expect(Findrepos.clean? 'repo').to be true
      end
    end

    context 'when the given repository has no commits' do
      it 'has tests'
    end
  end

  describe '.list' do
    before :context do
      Dir.mkdir 'repos'
      Dir.chdir 'repos' do
        create_repo 'a_clean_repo'

        create_repo 'a_dirty_repo'
        Dir.chdir('a_dirty_repo') { `echo "Hello, world!" > file` }

        Dir.mkdir 'not_a_repo'

        Dir.mkdir 'repo_inside'
        Dir.chdir('repo_inside') { create_repo 'another_repo' }
      end
    end

    after :context do
      FileUtils.rm_r 'repos'
    end

    context 'by default' do
      it 'lists all clean and dirty Git repositories in the current directory' do
        expect(Findrepos.list 'repos').to \
          contain_exactly('repos/a_clean_repo', 'repos/a_dirty_repo')
      end
    end

    context 'with recursion' do
      it 'lists all Git repositories in the current directory and all ' \
         'subdirectories' do
        expect(Findrepos.list('repos', 'all', true)).to \
          contain_exactly('repos/a_clean_repo', 'repos/a_dirty_repo',
                          'repos/repo_inside/another_repo')
      end
    end

    context 'when filter is "clean"' do
      it 'only lists clean repositories' do
        expect(Findrepos.list('repos', 'clean')).to \
          contain_exactly('repos/a_clean_repo')
      end
    end

    context 'when filter is "dirty"' do
      it 'only lists dirty repositories' do
        expect(Findrepos.list('repos', 'dirty')).to \
          contain_exactly('repos/a_dirty_repo')
      end
    end
  end
end
