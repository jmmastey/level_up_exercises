require_relative 'name_generator'
require_relative 'registry'
require_relative 'name_collision_error'

class Robot
  THREE_LETTERS_TWO_DIGITS = /[[:alpha:]]{2}[[:digit:]]{3}/

  attr_accessor :name
  attr_reader :registry

  def initialize(registry:, name: NameGenerator.new.generate_name(2, 3))
    @registry = registry
    @name = name

    add_to_registry(@registry)
  end

  private

  def add_to_registry(registry)
    unless valid_name?
      raise NameCollisionError, "There was a problem generating the Robot name!"
    end
    registry.list << name
  end

  def valid_name?
    (name =~ THREE_LETTERS_TWO_DIGITS) && !registry.include?(name)
  end
end

robot_registry = Registry.new(type: "robot")
robot = Robot.new(registry: robot_registry)
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
robot_2 = Robot.new(registry: robot_registry, name: 'AA111')
puts "My pet robot's name is #{robot_2.name}, but we usually call him junky."

robot_3 = Robot.new(registry: robot_registry, name: 'AA111')
puts "My pet robot's name is #{robot_3.name}, but we usually call him junky."
