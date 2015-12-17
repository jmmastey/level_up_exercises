require 'set'
class RobotRegistry
  def self.registry
    @registry ||= Set.new
  end
end
