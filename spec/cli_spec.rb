require 'spec_helper'

describe Repos::CLI do
  describe '#list' do
    before(:context) { create_repo_tree }

    after(:context) { FileUtils.rm_r 'dir' }

    context 'by default' do
      it 'lists git repositories in the current directory' do
        Dir.chdir 'dir' do
          expect { Repos::CLI.start %w(list) }.to \
            output("clean a_clean_repo\ndirty a_dirty_repo\n")
            .to_stdout
        end
      end

      it 'lists git repositories in the given directory' do
        expect { Repos::CLI.start %w(list dir) }.to \
          output("clean dir/a_clean_repo\ndirty dir/a_dirty_repo\n")
          .to_stdout
      end
    end

    context 'with --recursive' do
      it 'lists git repositories in the given directory and subdirectories' do
        expect { Repos::CLI.start %w(list dir --recursive) }.to \
          output("clean dir/a_clean_repo\ndirty dir/a_dirty_repo\nclean dir/repo_inside/another_repo\n").to_stdout
      end
    end

    context 'with --verbose' do
      it 'has tests'
    end

    context 'with --names' do
      it 'lists git repositories in the given directory without statuses' do
        expect { Repos::CLI.start %w(list dir --names) }.to \
          output("dir/a_clean_repo\ndir/a_dirty_repo\n").to_stdout
      end
    end

    context 'with --filter' do
      context 'when filter is "clean"' do
        it 'lists clean repositories' do
          expect { Repos::CLI.start %w(list dir --filter=clean) }.to \
            output("clean dir/a_clean_repo\n").to_stdout
        end
      end

      context 'when filter is "dirty"' do
        it 'lists dirty repositories' do
          expect { Repos::CLI.start %w(list dir --filter=dirty) }.to \
            output("dirty dir/a_dirty_repo\n").to_stdout
        end
      end
    end
  end

  describe '#say_git_status' do
    let(:cli) { Repos::CLI.new }

    it 'displays a clean repository' do
      expect do
        cli.send(:say_git_status, true, 'hello')
      end.to output("clean hello\n").to_stdout
    end

    it 'displays a dirty repository' do
      expect do
        cli.send(:say_git_status, false, 'hello')
      end.to output("dirty hello\n").to_stdout
    end
  end
end
