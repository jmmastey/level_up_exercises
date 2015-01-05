class NameCollisionError < RuntimeError; end

class Robot
  attr_accessor :name

  def initialize(args = {})
    @@registry ||= []
    @name_generator = args[:name_generator]
  end

  def name
    if @name_generator
      robot_name = @name_generator.call
    else
      robot_name = generate_characters + generate_numbers
    end
    raise NameCollisionError, "There was a problem generating the robot name!" unless name_valid?(robot_name)

    @@registry << robot_name
    robot_name
  end

  def generate_characters
    characters = ""
    2.times { characters << ('A'..'Z').to_a.sample }
    characters
  end

  def generate_numbers
    numbers = ""
    3.times { numbers << rand(10).to_s }
    numbers
  end

  def name_valid?(robot_name)
    (robot_name =~ /[[:alpha:]]{2}[[:digit:]]{3}/) && !@@registry.include?(robot_name)
  end
end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
# generator = -> { 'AA111' }
# Robot.new(name_generator: generator)
# Robot.new(name_generator: generator)
