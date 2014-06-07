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
          say_git_status true, repo if !options[:dirty]
        else
          say_git_status false, repo if !options[:clean]
        end
      end
    end

    default_command :list

    private

    def say_git_status(clean, message)
      status = clean ? 'clean' : 'dirty'
      color = clean ? :green : :red
      status = set_color status, color, true
      puts "#{status} #{message}"
    end
  end
end
