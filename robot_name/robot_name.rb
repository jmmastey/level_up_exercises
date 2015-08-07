require 'set'

# Public: General Robot Exception
class RobotError < RuntimeError; end

# Public: Exception describing a duplicate name
class NameCollisionError < RobotError; end

# Public: Exception denoting an invalid name
class NameValidationError < RobotError; end

# Public: A registry of unique robot names based on the Set class
#
# Examples
#
#   registry = RobotRegistry.new
#   registry << "B.E.N.D.E.R."
class RobotRegistry < Set
  # Public: Overrides the default Set::add method to throw an exception
  #         if a duplicate is detected.
  #
  # Returns self
  # Raises NameCollisionError if the name already exists in the registry
  def add(name)
    raise NameCollisionError,
      "#{name} is already in the registry!" if include?(name)

    super
  end

  # Public: Ensures that the << alias uses the child method
  alias_method :<<, :add
end

# Public: A named object
#
# Examples
#
#   robot = Robot.new(registry: RobotRegistry.new)
#   robot = Robot.new(registry: RobotRegistry.new,
#                     name_validator: -> (name) { !name.empty? })
class Robot
  # Public: Establishes getters for the name and registry attributes
  attr_reader :name, :registry

  # Internal: Establishes readers for the generator and validator
  attr_reader :name_generator, :name_validator

  # Public: Initializes a new Robot instance
  #
  # args - A Hash of arguments used to instantiate the instance
  #        :registry       - The RobotRegistry instance to register with
  #        :name_generator - A Proc or Method to generate a name (optional)
  #        :name_validator - A Proc or Method that returns true if the provided
  #                          name is valid. (optional)
  def initialize(args = {})
    @name_generator = args[:name_generator] || method(:generate_name)
    @name_validator = args[:name_validator] || method(:valid_name?)

    @registry       = args[:registry]
    @name           = name_generator.call

    validate
    register
  end

  # Internal: Registers the robot with the Registry
  #
  # Returns the RobotRegistry instance
  # Raises NameCollisionError on an invalid or duplicate name
  def register
    registry << name
  end

  # Internal: Validates the Robot
  #
  # Returns nothing
  # Raises NameValidationError if the name is not valid
  def validate
    raise NameValidationError,
      "#{name} is not a valid name!" unless name_validator.call(name)
  end

  # Internal: Generates a new random name. Used as the default generator.
  #
  # Returns the generated name as a String
  def generate_name
    generate_char = -> { ('A'..'Z').to_a.sample }
    generate_num = -> { rand(10) }

    "#{generate_char.call}#{generate_char.call}" \
      "#{generate_num.call}#{generate_num.call}#{generate_num.call}"
  end

  # Internal: Validates that the chose name conforms to the format of the
  #           default generator
  #
  # Returns Boolean true if the name is valid
  def valid_name?(name)
    name =~ /[[:alpha:]]{2}[[:digit:]]{3}/
  end
end

# Demonstrates the use of the classes
puts ""
puts "***********************************"
puts "* Robot Name Generator & Registry *"
puts "***********************************"
puts ""

registry = RobotRegistry.new

# Demonstrate Generator
begin
  3.times do
    robot = Robot.new(registry: registry)
    puts "Robot '#{robot.name}' Registered! (default generator and validator)"
  end
rescue RobotError => e
  puts "Error Generating Robot: #{e.message}"
end

puts ""

# Demonstrate Duplicates Checking
begin
  generator = -> { "AA111" }

  2.times do
    robot = Robot.new(registry: registry, name_generator: generator)
    puts "Robot '#{robot.name}' Registered! (static name, default validator)"
  end
rescue RobotError => e
  puts "Error Generating Robot: #{e.message}"
end

puts ""

# Demonstrate Validation
begin
  generator = -> { "TOBOR Model X-QQ66#{rand(10)}" }
  validator = -> (name) { name =~ /TOBOR Model X-[[:alpha:]]{2}[[:digit:]]{3}/ }

  2.times do
    robot = Robot.new(registry: registry,
                      name_generator: generator,
                      name_validator: validator)
    puts "Robot '#{robot.name}' Registered! (custom generator and validator)"
  end

  robot = Robot.new(registry: registry, name_validator: validator)
  puts "Robot '#{robot.name}' Registered! (custom generator, default validator)"
rescue RobotError => e
  puts "Error Generating Robot: #{e.message}"
end

puts ""
