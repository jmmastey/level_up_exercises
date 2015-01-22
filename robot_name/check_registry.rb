require 'set'

class CheckRegistry
  def self.name_exists?(registry, name)
    set = Set.new(registry)
    return true if set.include? name
  end
end
