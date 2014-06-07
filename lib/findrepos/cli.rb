require 'thor'
require 'pathname'

module Findrepos
  # The command line interface for the findrepos executable.
  class CLI < Thor
    desc 'list [DIRECTORY]', 'lists all Git repositories in the given directory'
    option :recursive,
           desc: 'finds Git repositories in subdirectories recursively',
           type: :boolean,
           aliases: :'-r'
    def list(directory = '.') # :nodoc:
      Findrepos.list(directory, recursive: options[:recursive]).each do |repo|
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
