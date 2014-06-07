require 'findrepos/version'
require 'findrepos/cli'

# The main module of findrepos, which includes its core functionality and more
# modules for supporting functionality.
module Findrepos
  # Lists all Git repository in the current directory. When recursive is true,
  # it also lists Git repositories found in subdirectories.
  #
  # ==== Attributes
  # * +directory+ - A String of the path to search for repositories within. This
  #   method will not check to see if the directory itself is a
  #   git repository. The path can be absolute or relative.
  #
  # ==== Options
  # * +:recursive+ - True if Git repositories should be searched for within
  #   subdirectories.
  def self.list(directory, recursive: false)
    pattern = recursive ? '**/.git' : '*/.git'
    Dir.glob("#{directory}/#{pattern}").map do |git_directory|
      Pathname.new(git_directory).dirname.to_s
    end
  end

  # Returns true when the given repository has neigher uncommitted changes nor
  # untracked files. Expects the repository to have at least one commit.
  #
  # ==== Attributes
  # * +repo+ - A String of the path to the repository to check. The path can be
  #   absolute or relative.
  def self.clean?(repo)
    Dir.chdir(repo) do
      empty_diff = system('git diff-index --quiet HEAD')
      untracked = `git ls-files --other --directory --exclude-standard` != ''
      empty_diff && !untracked
    end
  end
end
