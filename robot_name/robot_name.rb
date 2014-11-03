require_relative 'robot_name_registry'
require_relative 'robot_name_generator'
require_relative 'registry_error'

class Robot
  attr_reader :name

  def initialize(registry, params = {})
    raise RegistryError unless registry.is_a?(RobotNameRegistry)
    generator = RobotNameGenerator.new(params[:schema])
    name  = generator.generate(params[:name_generator])
    registry.add(name)
    @name = name
  end
end
