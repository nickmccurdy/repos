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

    context 'with an untracked file' do
      it 'returns false' do
        Dir.chdir('repo') { FileUtils.touch 'README' }
        expect(Repos.clean? 'repo').to be false
      end
    end

    context 'with a modified file in the working tree' do
      it 'returns false' do
        Dir.chdir('repo') { File.open('file', 'w') { |f| f.write('hello') } }
        expect(Repos.clean? 'repo').to be false
      end
    end

    context 'with a modified file in the stage' do
      it 'returns false' do
        Dir.chdir 'repo' do
          File.open('file', 'w') { |f| f.write('hello') }
          `git add file`
        end
        expect(Repos.clean? 'repo').to be false
      end
    end

    context 'with neither uncommitted nor untracked changes' do
      it 'returns true' do
        expect(Repos.clean? 'repo').to be true
      end
    end

    context 'with no commits' do
      context 'and no untracked files' do
        it 'returns true'
      end

      context 'and an untracked file' do
        it 'returns false'
      end

      context 'and an empty directory' do
        it 'returns true'
      end
    end
  end

  describe '.list' do
    before(:context) { create_repo_tree }

    after(:context) { FileUtils.rm_r 'dir' }

    context 'by default' do
      it 'lists git repositories in the given directory' do
        expect(Repos.list 'dir').to eq [
          'dir/a_clean_repo',
          'dir/a_dirty_repo'
        ]
      end
    end

    context 'with recursion' do
      it 'lists git repositories in the given directory and subdirectories' do
        expect(Repos.list('dir', 'all', true)).to eq [
          'dir/a_clean_repo',
          'dir/a_dirty_repo',
          'dir/repo_inside/another_repo'
        ]
      end
    end

    context 'with the "clean" filter' do
      it 'lists clean repositories' do
        expect(Repos.list('dir', 'clean')).to eq ['dir/a_clean_repo']
      end
    end

    context 'with the "dirty" filter' do
      it 'lists dirty repositories' do
        expect(Repos.list('dir', 'dirty')).to eq ['dir/a_dirty_repo']
      end
    end
  end
end
