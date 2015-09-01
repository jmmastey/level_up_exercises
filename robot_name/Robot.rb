require_relative "errors"
require_relative "robot_registry"

class Robot
  attr_reader :name

  ERROR_INVALID_REGISTRY = "Registry is invalid. Must be type RobotRegistry."

  class << self
    attr_reader :registry
    
    def registry=(input_registry)
      raise ArgumentError, ERROR_INVALID_REGISTRY unless is_valid_registry?(input_registry)
      @registry = input_registry
    end
  end

  def initialize(args = {})
    self.class.registry ||= args[:use_registry] if self.class.is_valid_registry?(args[:use_registry])
    self.class.registry ||= RobotRegistry.new
    @name = parse_name_generator(args[:name_generator]) || generate_robot_name
    self.class.register_robot(self)
  end

  def self.register_robot(robot)
    registry.add_robot_to_registry(robot.name)
  end

  def self.is_valid_registry?(input_registry)
    input_registry.instance_of?(RobotRegistry)
  end

  private

  def parse_name_generator(name_generator)
    return false if name_generator.nil?
    name_generator.call
  end

  def generate_robot_name
    generate_char(2).concat(generate_num(3))
  end

  def generate_char(length = 1)
    length.times.map { [*'A'..'Z'].sample }.join("")
  end

  def generate_num(length = 1)
    length.times.map { rand(10) }.join("")
  end
end
