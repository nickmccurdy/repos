require 'findrepos/version'
require 'findrepos/cli'

module Findrepos
  def self.list(directory, recursive: false)
    pattern = recursive ? '**/.git' : '*/.git'
    Dir.glob("#{directory}/#{pattern}").map do |git_directory|
      Pathname.new(git_directory).dirname.to_s
    end
  end

  def self.clean?(repo)
    Dir.chdir(repo) do
      empty_diff = system('git diff-index --quiet HEAD')
      untracked = `git ls-files --other --directory --exclude-standard` != ''
      empty_diff && !untracked
    end
  end
end
