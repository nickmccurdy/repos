# Repos
[![Gem Version](https://badge.fury.io/rb/repos.svg)](http://badge.fury.io/rb/repos)
[![Build Status](https://travis-ci.org/nicolasmccurdy/repos.svg?branch=master)](https://travis-ci.org/nicolasmccurdy/repos)
[![Dependency Status](https://gemnasium.com/nicolasmccurdy/repos.svg)](https://gemnasium.com/nicolasmccurdy/repos)
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

## Contributing
1. Fork it ( https://github.com/nicolasmccurdy/repos/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
