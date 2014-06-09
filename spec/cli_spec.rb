require 'spec_helper'

describe Findrepos::CLI do
  let(:cli) { Findrepos::CLI.new }

  describe '#list' do
    it 'has tests'
  end

  describe '#say_git_status' do
    context 'by default' do
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
end
