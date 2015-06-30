class NameCollisionError < RuntimeError; end
class InvalidNameError < RuntimeError; end

class RobotRegistry
  attr_accessor :robot_name

  @registry = []
  DUP_NAME_ERR_MSG = "Robot name already exists in Robot Registry"

  def self.add_name_to_registry(robot_name)
    @robot_name = robot_name
    raise NameCollisionError, DUP_NAME_ERR_MSG if @registry.include?(robot_name)
    @registry << robot_name
    puts "Added #{robot_name} to registry: #{@registry}"
    rescue NameCollisionError => e
      puts "Error: #{robot_name}.  #{e}"
  end
end

class Robot
  attr_accessor :name
  INVALID_NAME_MSG = "The name is invalid"

  def initialize(args = {})
    @name = args[:name_generator] || generate_name
    RobotRegistry.add_name_to_registry(name) if name_valid?
  end

  def generate_name
    @name = ('A'..'Z').to_a.sample(2).join + rand(0..999).to_s.rjust(3, "0")
  end

  def name_valid?
    return true if name =~ /[[:alpha:]]{2}[[:digit:]]{3}/
    raise InvalidNameError, INVALID_NAME_MSG
    rescue InvalidNameError => e
      puts "Error: #{name}. #{e}"
  end
end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."
robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."
# Errors!
name_generator = -> { 'AA111' }
Robot.new(name_generator: name_generator.call)
puts "My pet robot's name is #{name_generator.call}, \
but we usually call him sparky."
Robot.new(name_generator: name_generator.call)
robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."
name_generator = -> { 'ZZZ' }
Robot.new(name_generator: name_generator.call)
robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."
