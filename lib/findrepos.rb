require "findrepos/version"
require "pathname"

module Findrepos
  def self.list
    Dir.glob('*/.git').map { |dir| Pathname.new(dir).dirname }
  end
end
