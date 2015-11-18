require_relative 'name_generator'
require_relative 'registry'
require_relative 'name_collision_error'
require 'pry'

class Robot
  VALID_ROBOT_NAME = /[[:alpha:]]{2}[[:digit:]]{3}/

  attr_accessor :name
  attr_reader :registry, :name_generator

  def initialize(name_generator: nil)
    @registry = self.class.registry
    @name_generator = name_generator
    generate_name
    add_to_registry(@registry)
  end

  def self.registry
    @registry ||= Registry.new
  end

  private

  def generate_name
    self.name = name_generator.call
  end

  def add_to_registry(registry)
    check_for_valid_name
    registry.add(name)
  end

  def check_for_valid_name
    if name && invalid_name?
      raise NameCollisionError, "That Robot name is invalid!"
    end
  end

  def invalid_name?
    !(name =~ VALID_ROBOT_NAME)
  end
end

generator = NameGenerator.new
generator_2 = -> { 'AA111' }
robot = Robot.new(name_generator: generator)
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
robot_2 = Robot.new(name_generator: generator_2)
puts "My pet robot's name is #{robot_2.name}, but we usually call him junky."

robot_3 = Robot.new(name_generator: generator_2)
puts "My pet robot's name is #{robot_3.name}, but we usually call him junky."
