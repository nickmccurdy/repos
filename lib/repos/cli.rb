require 'highline/import'
require 'slop'

module Repos
  # The command line interface for the repos executable.
  module CLI
    def self.start(args) # :nodoc:
      options = Slop.parse! args, help: true do
        banner "Usage: repos [DIRECTORY]\nlists all Git repositories in the given directory\n"

        on :r, :recursive, 'finds Git repositories in subdirectories recursively'
        on :v, :verbose,   'shows additional repository information, including the status and list of stashes'
        on :n, :names,     'only displays paths to repositories'
        on :f=, :filter=,  'finds clean repositories only, dirty repositories only, or all repositories', default: 'all'
      end

      directory = args[0] || '.'

      Repos.list(directory,
                 options[:filter],
                 options.recursive?).each do |repository|
        if options.names?
          puts repository
        else
          CLI.say_git_status(Repos.clean?(repository), repository)
        end

        if options.verbose?
          Dir.chdir repository do
            system 'git status'
            system 'git --no-pager stash list'
            puts
          end
        end
      end
    end

    private

    def self.say_git_status(clean, message)
      status = clean ? 'clean' : 'dirty'
      color = clean ? :green : :red
      # TODO: Figure out a good way to conditionally disable color output
      status = HighLine.color(status, color, :bold)
      puts "#{status} #{message}"
    end
  end
end
