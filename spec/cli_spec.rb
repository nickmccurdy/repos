require 'spec_helper'

describe Findrepos::CLI do
  describe '#list' do
    before(:context) { create_repo_tree }

    after(:context) { FileUtils.rm_r 'repos' }

    context 'by default' do
      it 'lists all clean and dirty Git repositories in the current ' \
        'directory' do
        expect { Findrepos::CLI.start %w(list repos) }.to \
          output("clean repos/a_clean_repo\ndirty repos/a_dirty_repo\n")
          .to_stdout
      end
    end

    context 'with --recursive' do
      it 'lists all Git repositories in the current directory and all ' \
      'subdirectories' do
        expect { Findrepos::CLI.start %w(list repos --recursive) }.to \
          output("clean repos/a_clean_repo\ndirty repos/a_dirty_repo\nclean repos/repo_inside/another_repo\n").to_stdout
      end
    end

    context 'with --verbose' do
      it 'has tests'
    end

    context 'with --names' do
      it 'lists all clean and dirty Git repositories in the current ' \
        'directory' do
        expect { Findrepos::CLI.start %w(list repos --names) }.to \
          output("repos/a_clean_repo\nrepos/a_dirty_repo\n").to_stdout
      end
    end

    context 'with --filter' do
      context 'when filter is "clean"' do
        it 'only lists clean repositories' do
          expect { Findrepos::CLI.start %w(list repos --filter=clean) }.to \
            output("clean repos/a_clean_repo\n").to_stdout
        end
      end

      context 'when filter is "dirty"' do
        it 'only lists dirty repositories' do
          expect { Findrepos::CLI.start %w(list repos --filter=dirty) }.to \
            output("dirty repos/a_dirty_repo\n").to_stdout
        end
      end
    end
  end

  describe '#say_git_status' do
    let(:cli) { Findrepos::CLI.new }

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
