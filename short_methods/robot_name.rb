require 'faker'

class RobotNamer

  def initialize
    @name_registry = []
    @char_generator = -> { ('A'..'Z').to_a.sample }
    @num_generator = -> { rand(10) }
  end


  def generate_robot_name

    robot_name = generate_random_name

    # it's possible that our generator sucks
    # and that we use all possible combinations
    while name_exists?(robot_name)
      puts "We have a collision: #{robot_name}"
      robot_name = generate_random_name
    end

    @name_registry << robot_name

    robot_name
  end

  def name_exists?(name)
    @name_registry.include?(name)
  end

  def generate_random_name
    return "#{gen_char}#{gen_char}#{gen_num}#{gen_num}#{gen_num}"
  end

  def gen_char
    @char_generator.call
  end

  def gen_num
    @num_generator.call
  end


end

class BadRobotNamer < RobotNamer

  def initialize
    @name_registry = []
    @char_generator = -> { ('A'..'Z').to_a.sample }
    @num_generator = -> { rand(5) }
  end

  def generate_random_name
    return "#{gen_char}#{gen_num}#{gen_num}"
  end

end

class Robot

  @@default_namer = RobotNamer.new

  attr_accessor :given_name, :robot_name

  def initialize(given_name, namer = @@default_namer)

    @given_name = given_name
    @robot_name = namer.generate_robot_name

  end


end


namer = BadRobotNamer.new
# namer = RobotNamer.new

100.times do
  robot = Robot.new("Sparky", namer)

  puts "My pet robot's name is #{robot.robot_name}, but we usually call him #{robot.given_name}."
end



# Errors!
# generator = -> { 'AA111' }
# Robot.new(name_generator: generator)
# Robot.new(name_generator: generator)
