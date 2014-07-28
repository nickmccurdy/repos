require 'spec_helper'

describe Repos do
  describe '.VERSION' do
    it 'exists' do
      expect(Repos::VERSION).not_to be nil
    end
  end

  describe '.clean?' do
    before(:example) { create_repo 'repo' }

    after(:example) { FileUtils.rm_r 'repo' }

    context 'when the given repository has an untracked file' do
      it 'returns false' do
        Dir.chdir('repo') { FileUtils.touch 'README' }
        expect(Repos.clean? 'repo').to be false
      end
    end

    context 'when the given repository has a modified file in the working ' \
            'tree' do
      it 'returns false' do
        Dir.chdir('repo') { File.open('file', 'w') { |f| f.write('hello') } }
        expect(Repos.clean? 'repo').to be false
      end
    end

    context 'when the given repository has a modified file in the stage' do
      it 'returns false' do
        Dir.chdir 'repo' do
          File.open('file', 'w') { |f| f.write('hello') }
          `git add file`
        end
        expect(Repos.clean? 'repo').to be false
      end
    end

    context 'when the given repository has neither uncommitted changes nor ' \
            'untracked files' do
      it 'returns true' do
        expect(Repos.clean? 'repo').to be true
      end
    end

    context 'when the given repository has no commits' do
      context 'and is otherwise empty' do
        it 'returns true'
      end

      context 'and has a file' do
        it 'returns false'
      end

      context 'and has an empty directory' do
        it 'returns true'
      end
    end
  end

  describe '.list' do
    before(:context) { create_repo_tree }

    after(:context) { FileUtils.rm_r 'dir' }

    context 'by default' do
      it 'lists all clean and dirty Git repositories in the current ' \
         'directory' do
        expect(Repos.list 'dir').to eq [
          'dir/a_clean_repo',
          'dir/a_dirty_repo'
        ]
      end
    end

    context 'with recursion' do
      it 'lists all Git repositories in the current directory and all ' \
         'subdirectories' do
        expect(Repos.list('dir', 'all', true)).to eq [
          'dir/a_clean_repo',
          'dir/a_dirty_repo',
          'dir/repo_inside/another_repo'
        ]
      end
    end

    context 'when filter is "clean"' do
      it 'only lists clean repositories' do
        expect(Repos.list('dir', 'clean')).to eq ['dir/a_clean_repo']
      end
    end

    context 'when filter is "dirty"' do
      it 'only lists dirty repositories' do
        expect(Repos.list('dir', 'dirty')).to eq ['dir/a_dirty_repo']
      end
    end
  end
end
