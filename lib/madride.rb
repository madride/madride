require "madride/version"


module Madride
  autoload :Environment,  "madride/environment"
  autoload :Server,       "madride/server"


  @paths = []


  def self.append_path path
    @paths << path
  end


  def self.paths
    @paths.dup
  end
end
