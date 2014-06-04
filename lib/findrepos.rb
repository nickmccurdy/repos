require 'findrepos/version'
require 'findrepos/cli'

module Findrepos
  def self.list(recursive: false)
    pattern = recursive ? '**/.git' : '*/.git'
    Dir.glob(pattern).map { |dir| Pathname.new(dir).dirname.to_s }
  end

  def self.clean?(repo)
    Dir.chdir(repo) do
      empty_diff = system('git diff-index --quiet HEAD')
      untracked = `git ls-files --other --directory --exclude-standard` != ''
      empty_diff && !untracked
    end
  end
end
