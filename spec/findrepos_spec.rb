require 'spec_helper'

describe Findrepos do
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

  it 'has a version number' do
    expect(Findrepos::VERSION).not_to be nil
  end

  it 'lists all Git repositories in the current directory' do
    Dir.chdir 'repos' do
      expect(Findrepos.list).to eq ['a_repo', 'repo_inside/another_repo']
    end
  end
end
