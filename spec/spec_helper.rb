require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'findrepos'

def create_repo(name)
  Dir.mkdir name
  Dir.chdir name do
    `git init`
    `git config user.name "Example"`
    `git config user.email "example@example.com"`

    FileUtils.touch 'file'
    `git add file`
    `git commit -m "Initial commit."`
  end
end

def create_repo_tree
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