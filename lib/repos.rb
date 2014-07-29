require 'repos/version'
require 'repos/cli'

# The main module of repos, which includes its core functionality and more
# modules for supporting functionality.
module Repos
  # Lists all Git repositories in the given directory. When recursive is true,
  # it also lists Git repositories found in subdirectories.
  #
  # ==== Attributes
  # * +directory+ - A String of the path to search for repositories within. This
  #   method will not check to see if the directory itself is a
  #   git repository. The path can be absolute or relative.
  # * +filter+ - 'clean' to find clean repositories only, 'dirty' to find dirty
  #   repositories only, and anything else to find all repositories (dirty or
  #   clean).
  # * +recursive+ - True if Git repositories should be searched for within
  #   subdirectories.
  def self.list(directory, filter = 'all', recursive = false)
    pattern = recursive ? '**/.git' : '*/.git'
    repositories = Dir.glob("#{directory}/#{pattern}").sort.map do |git_directory|
      Pathname.new(git_directory).dirname.to_s
    end
    is_clean = proc { |repository| Repos.clean?(repository) }

    case filter
    when 'clean' then repositories.select(&is_clean)
    when 'dirty' then repositories.reject(&is_clean)
    else repositories
    end
  end

  # Returns true when the given repository has neigher uncommitted changes nor
  # untracked files. Expects the repository to have at least one commit.
  #
  # ==== Attributes
  # * +repository+ - A String of the path to the repository to check. The path
  #   can be absolute or relative.
  def self.clean?(repository)
    Dir.chdir(repository) do
      empty_diff = system('git diff-index --quiet HEAD')
      untracked = `git ls-files --other --directory --exclude-standard` != ''
      empty_diff && !untracked
    end
  end
end
