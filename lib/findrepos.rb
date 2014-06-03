require "findrepos/version"
require "thor"
require "pathname"

class Findrepos < Thor
  desc 'list', 'lists all Git repositories in the current directory'
  def list
    puts Dir.glob('*/.git').map { |dir| Pathname.new(dir).dirname }
  end

  default_command :list
end
