# This class is used to define errors for Regions
class NameCollisionError < RuntimeError
  def message
    'There was a problem generating the robot name!'
  end
end

# Generate Robot Name Code
class Robot
  attr_accessor :name

  def check_name(args)
    @name_generator = args[:name_generator]
    @name = @name_generator.call if @name_generator
    check_error if @name_generator
  end

  def generate_name
    prefix = ('A'..'Z').to_a.sample(2).join
    suffix = (100..999).to_a.sample(1).join
    @name =  prefix + suffix
    check_error
  end

  def check_error
    puts @name
    raise NameCollisionError unless (@name =~ /[[:alpha:]]{2}[[:digit:]]{3}/) || @registry.include?(@name)
  end

  def initialize(args = {})
    @registry ||= []
    check_name(args)
    generate_name unless @name
    @registry << @name
  end
end
generator = -> { 'AA111' }
robot = Robot.new(name_generator: generator)
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
# generator = -> { 'AA111' }
# Robot.new(name_generator: generator)
# Robot.new(name_generator: generator)
