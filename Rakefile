require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rdoc/task'

RSpec::Core::RakeTask.new(:spec)

RDoc::Task.new do |rdoc|
  rdoc.rdoc_dir = 'doc'
  rdoc.main = 'README.md'
  rdoc.rdoc_files.include('README.md', 'lib/**/*.rb')
end

task default: :spec
