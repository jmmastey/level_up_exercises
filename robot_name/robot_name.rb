class NameCollisionError < RuntimeError; end

class RobotRegistry
  @registry = []
  NAME_COLL_ERR_MSG = "There was a problem generating the robot name!"

  def self.add_to_registry(name)
    raise NameCollisionError, NAME_COLL_ERR_MSG if @registry.include?(name)
    @registry << name
    puts "robot list is #{@registry}"
    rescue NameCollisionError => e
      puts "Error is #{e}"
  end
end

class Robot
  attr_accessor :name

  def initialize(args = {})
    @name = args[:name_generator] || generate_name
    puts "Name is #{@name}"
    RobotRegistry.add_to_registry(@name)
  end

  def generate_name
    @name = ('A'..'Z').to_a.sample(2).join + rand(0..999).to_s.rjust(3, "0")
  end

  def name_valid?
    @name =~ /[[:alpha:]]{2}[[:digit:]]{3}/
  end
end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."
robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."
# Errors!
generator = -> { 'AA111' }
Robot.new(name_generator: generator.call)
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."
Robot.new(name_generator: generator.call)
robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."
