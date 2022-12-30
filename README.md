# Repos
[![Gem Version](https://badge.fury.io/rb/repos.svg)](http://badge.fury.io/rb/repos)
[![Build Status](https://travis-ci.org/nicolasmccurdy/repos.svg?branch=master)](https://travis-ci.org/nicolasmccurdy/repos)
[![Code Climate](https://codeclimate.com/github/nicolasmccurdy/findrepos.png)](https://codeclimate.com/github/nicolasmccurdy/findrepos)
[![Coverage Status](https://codeclimate.com/github/nicolasmccurdy/findrepos/coverage.png)](https://codeclimate.com/github/nicolasmccurdy/findrepos)

A tool for finding git repositories locally.

## Installation
    $ gem install repos

## Usage
    Usage:
      repos list [DIRECTORY]
    
    Options:
      -r, [--recursive], [--no-recursive]  # finds Git repositories in subdirectories recursively
      -v, [--verbose], [--no-verbose]      # shows additional repository information, including the status and list of stashes
      -n, [--names], [--no-names]          # only displays paths to repositories
      -f, [--filter=all|clean|dirty]       # finds clean repositories only, dirty repositories only, or all repositories
                                           # Default: all
    
    lists all Git repositories in the given directory
Also aliased to `repos`.
      
## Example
    $ repos
    clean ./bundler
    clean ./rails
    dirty ./repos

## Development
After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing
Bug reports and pull requests are welcome on GitHub at https://github.com/nicolasmccurdy/repos.
