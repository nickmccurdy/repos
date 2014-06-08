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
