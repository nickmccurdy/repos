require 'thor'

module Repos
  # The command line interface for the repos executable.
  class CLI < Thor
    desc 'list [DIRECTORY]', 'lists all Git repositories in the given directory'
    option :recursive,
           desc: 'finds Git repositories in subdirectories recursively',
           type: :boolean,
           aliases: :'-r'
    option :verbose,
           desc: 'shows additional repository information, including the ' \
                 'status and list of stashes',
           type: :boolean,
           aliases: :'-v'
    option :names,
           desc: 'only displays paths to repositories',
           type: :boolean,
           aliases: :'-n'
    option :filter,
           desc: 'finds clean repositories only, dirty repositories only, or ' \
                 'all repositories',
           banner: 'all|clean|dirty',
           default: 'all',
           type: :string,
           aliases: :'-f'
    def list(directory = '.') # :nodoc:
      Repos.list(directory,
                 options[:filter],
                 options[:recursive]).each do |repository|
        if options[:names]
          say repository
        else
          say_git_status(Repos.clean?(repository), repository)
        end

        if options[:verbose]
          Dir.chdir repository do
            system 'git status'
            system 'git --no-pager stash list'
            puts
          end
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
