require_relative 'robot_name_factory'
require_relative 'robot_name_factory_error'

class Robot
  attr_reader :name

  def initialize(registry, parameters = {})
    raise RobotNameFactoryError unless registry.is_a? RobotNameFactory

    name_generator = parameters[:name_generator]
    registry.generate_name(name_generator)
  end
end
