require 'thor'
require 'pathname'

module Findrepos
  class CLI < Thor
    desc 'list', 'lists all Git repositories in the current directory'
    def list
      puts Dir.glob('*/.git').map { |dir| Pathname.new(dir).dirname }
    end

    default_command :list
  end
end
