require 'spec_helper'

describe Findrepos::CLI do
  let(:cli) { Findrepos::CLI.new }

  describe '#list' do
    it 'has tests'
  end

  describe '#say_git_status' do
    context 'by default' do
      it 'displays a clean repo' do
        expect do
          cli.send(:say_git_status, true, 'hello')
        end.to output("clean hello\n").to_stdout
      end

      it 'displays a dirty repo' do
        expect do
          cli.send(:say_git_status, false, 'hello')
        end.to output("dirty hello\n").to_stdout
      end
    end

    context 'when filter is "clean"' do
      it 'displays a clean repo' do
        expect do
          cli.send(:say_git_status, true, 'hello', 'clean')
        end.to output("clean hello\n").to_stdout
      end

      it 'does not display a dirty repo' do
        expect do
          cli.send(:say_git_status, false, 'hello', 'clean')
        end.to_not output.to_stdout
      end
    end

    context 'when filter is "dirty"' do
      it 'does not display a clean repo' do
        expect do
          cli.send(:say_git_status, true, 'hello', 'dirty')
        end.to_not output.to_stdout
      end

      it 'displays a dirty repo' do
        expect do
          cli.send(:say_git_status, false, 'hello', 'dirty')
        end.to output("dirty hello\n").to_stdout
      end
    end
  end
end
