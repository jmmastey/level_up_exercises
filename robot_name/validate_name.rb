require 'set'

class ValidateName
  def self.name_exists?(registry, name)
    set = Set.new(registry)
    return true if set.include? name
  end

  def self.match_regex?(name)
    return true unless (/[[:alpha:]]{2}[[:digit:]]{3}/ =~ name).nil?
  end
end
