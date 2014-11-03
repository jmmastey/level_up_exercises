require_relative 'registry'
require_relative 'registry_error'

class Robot
  attr_reader :name

  def initialize(registry, parameters = {})
    raise RegistryError unless registry.is_a? RobotNameRegistry

    name_generator = parameters[:name_generator]
    registry.generate_name(name_generator)
  end
end
