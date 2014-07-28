require 'spec_helper'

describe Repos::CLI do
  describe '#list' do
    before(:context) { create_repo_tree }

    after(:context) { FileUtils.rm_r 'dir' }

    context 'by default' do
      it 'lists all clean and dirty Git repositories in the current ' \
        'directory' do
        expect { Repos::CLI.start %w(dir) }.to \
          output(%r(.*clean.* dir/a_clean_repo\n.*dirty.* dir/a_dirty_repo\n))
          .to_stdout
      end
    end

    context 'with --recursive' do
      it 'lists all Git repositories in the current directory and all ' \
      'subdirectories' do
        expect { Repos::CLI.start %w(dir --recursive) }.to \
          output(%r(.*clean.* dir/a_clean_repo\n.*dirty.* dir/a_dirty_repo\n.*clean.* dir/repo_inside/another_repo\n)).to_stdout
      end
    end

    context 'with --verbose' do
      it 'has tests'
    end

    context 'with --names' do
      it 'lists all clean and dirty Git repositories in the current ' \
        'directory' do
        expect { Repos::CLI.start %w(dir --names) }.to \
          output("dir/a_clean_repo\ndir/a_dirty_repo\n").to_stdout
      end
    end

    context 'with --filter' do
      context 'when filter is "clean"' do
        it 'only lists clean repositories' do
          expect { Repos::CLI.start %w(dir --filter=clean) }.to \
            output(%r(.*clean.* dir/a_clean_repo\n)).to_stdout
        end
      end

      context 'when filter is "dirty"' do
        it 'only lists dirty repositories' do
          expect { Repos::CLI.start %w(dir --filter=dirty) }.to \
            output(%r(.*dirty.* dir/a_dirty_repo\n)).to_stdout
        end
      end
    end
  end

  describe '#say_git_status' do
    let(:cli) { Repos::CLI.new }

    it 'displays a clean repository' do
      expect do
        cli.send(:say_git_status, true, 'hello')
      end.to output(/.*clean.* hello\n/).to_stdout
    end

    it 'displays a dirty repository' do
      expect do
        cli.send(:say_git_status, false, 'hello')
      end.to output(/.*dirty.* hello\n/).to_stdout
    end
  end
end
