require './lib/default_name_generator'
require './lib/registry'

class Robot
  attr_accessor :name
  MAX_ATTEMPTS = 10

  def initialize(generator: DefaultNameGenerator.new, registry: Registry.new)
    @name_generator = generator
    @registry = registry
    @max_attempts = MAX_ATTEMPTS

    produce_valid_name
  end

  def generate_self_name
    @name = @name_generator.call
  end

  def produce_valid_name
    generate_self_name
    @registry.add_entry(name)
  rescue Registry::CollisionError
    max_attempts -= 1
    retry unless @max_attempts.zero?
  rescue
    raise
  end
end

registry = Registry.new
robot = Robot.new(registry: registry)
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
# generator = -> { 'AA111' }
# Robot.new(name_generator: generator)
# Robot.new(name_generator: generator)
