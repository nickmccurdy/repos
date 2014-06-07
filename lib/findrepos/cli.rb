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
    option :clean,
           desc: 'finds clean repositories only',
           type: :boolean
    option :dirty,
           desc: 'finds dirty repositories only',
           type: :boolean
    def list(directory = '.') # :nodoc:
      Findrepos.list(directory, recursive: options[:recursive]).each do |repo|
        if Findrepos.clean?(repo)
          say_status 'clean', repo, :green if !options[:dirty]
        else
          say_status 'dirty', repo, :red if !options[:clean]
        end
      end
    end

    default_command :list
  end
end
