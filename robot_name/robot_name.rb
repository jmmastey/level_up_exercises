require_relative 'registry'

class Robot
  attr_reader :name

  def initialize(registry, parameters = {})
    @registry = registry
    @name_generator = parameters[:name_generator]
    generate_name
  end

  def generate_name
    @registry.generate_name(@name_generator)
  end

  private :generate_name
end
