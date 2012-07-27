require "madride/version"
require "madride/environment"


module Madride
  @paths = []


  def self.append_path path
    @paths << path
  end


  def self.paths
    @paths.dup
  end
end
