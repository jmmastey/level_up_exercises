class RegistryError < StandardError; end

class RobotRegistry
  attr_accessor :robot_name

  @registry = []
  DUP_NAME_ERR_MSG = "Robot name already exists in Robot Registry"

  def self.add_name_to_registry(robot_name)
    @robot_name = robot_name
    raise RegistryError, DUP_NAME_ERR_MSG if @registry.include?(robot_name)
      @registry << robot_name
      puts "Added #{robot_name} to registry: #{@registry}"
  end
end

class Robot
  attr_accessor :name
  INVALID_NAME_MSG = "The name is invalid"

  def initialize(args = nil)
    args ? @name = args.call : @name = generate_name
    puts "Robot name is #{name}"
    RobotRegistry.add_name_to_registry(name) if name_valid?
  rescue RegistryError => e
    puts "Error: #{name}. #{e}"
  end

  def generate_name
    generate_name_letters << generate_name_numbers
  end

  def generate_name_letters
    ('A'..'Z').to_a.sample(2).join
  end

  def generate_name_numbers
    rand(0..999).to_s.rjust(3, "0")
  end

  def name_valid?
    return true if name =~ /[[:alpha:]]{2}[[:digit:]]{3}/
    puts "Error: #{name}. #{INVALID_NAME_MSG}"
  end
end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."
robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."
name_generator = -> { 'AA111' }
robot = Robot.new(name_generator)
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."
robot = Robot.new(name_generator)
puts "Will show error message above"
robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."
name_generator = -> { 'ZZZ' }
puts "Will show error message above"
robot = Robot.new(name_generator)
robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."
name_generator = -> { 'AA111' }
robot = Robot.new(name_generator)
puts "--> My pet robot's name is #{robot.name}, but we usually call him sparky."
