require 'thor'
require 'pathname'

module Findrepos
  class CLI < Thor
    desc 'list', 'lists all Git repositories in the current directory'
    def list
      Findrepos.list.each do |repo|
        if Findrepos.clean?(repo)
          say_status 'clean', repo, :green
        else
          say_status 'dirty', repo, :red
        end
      end
    end

    default_command :list
  end
end
