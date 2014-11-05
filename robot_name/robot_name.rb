require_relative 'robot_name_registry'
require_relative 'robot_name_generator'

class Robot
  attr_reader :name

  def initialize(registry, params = {})
    @generator = RobotNameGenerator.new(params)
    @registry = registry
    reset_name
  end

  def reset_name
    @name = @generator.generate.tap { |name| @registry.push(name) }
  end
end
