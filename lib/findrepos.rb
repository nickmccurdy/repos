require 'findrepos/version'
require 'findrepos/cli'

module Findrepos
  def self.list(recursive: false)
    pattern = recursive ? '**/.git' : '*/.git'
    Dir.glob(pattern).map { |dir| Pathname.new(dir).dirname.to_s }
  end

  def self.clean?(repo)
    is_clean = nil
    Dir.chdir(repo) { is_clean = system 'git diff-index --quiet HEAD' }
    is_clean
  end
end
