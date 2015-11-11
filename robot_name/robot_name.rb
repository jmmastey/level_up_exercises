require_relative 'robot_name_errors.rb'

class RobotName
  attr_accessor :name

  @@registry

  def initialize(args = {})
    @@registry ||= []
    @name_generator = args[:name_generator]
    generate_name
  end

  def alpha_char
    ('A'..'Z').to_a.sample
  end

  def digit
    rand(10)
  end

  def invalid_name?
    !(name =~ /[[:alpha:]]{2}[[:digit:]]{3}/) || @@registry.include?(name)
  end

  def rand_name_generator
    @name = "#{alpha_char}#{alpha_char}#{digit}#{digit}#{digit}"
    return @name unless invalid_name?
    raise NameCollisionError, "There was a problem generating the robot name!"
  end

  def generate_name
    @name = @name_generator ? name_generator.call : rand_name_generator
    @@registry << @name
  end
end

robot = RobotName.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
# generator = -> { 'AA111' }
# Robot.new(name_generator: generator)
