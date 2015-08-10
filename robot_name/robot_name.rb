require_relative "errors.rb"
require_relative "registry.rb"

class Robot
  attr_reader :name, :registry
  attr_reader :name_generator, :name_validator

  def initialize(args = {})
    @name_generator = args[:name_generator] || method(:generate_name)
    @name_validator = args[:name_validator] || method(:valid_name?)
    @registry = args[:registry]
    @name = name_generator.call

    validate
    register
  end

  def register
    registry << name
  end

  def validate
    raise NameValidationError,
      "#{name} is not a valid name!" unless name_validator.call(name)
  end

  def generate_name
    new_name = ""

    2.times { new_name.concat(('A'..'Z').to_a.sample) }
    3.times { new_name.concat(rand(10).to_s) }

    new_name
  end

  def valid_name?(name)
    name =~ /[[:alpha:]]{2}[[:digit:]]{3}/
  end
end

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
