require 'findrepos/version'
require 'findrepos/cli'

module Findrepos
  def self.list
    Dir.glob('*/.git').map { |dir| Pathname.new(dir).dirname.to_s }
  end
end
