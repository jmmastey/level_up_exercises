class NameCollisionError < RuntimeError; end

class Robot
  attr_accessor :name

  def initialize(args = {})
    @@registry ||= []
    @name_generator = args[:name_generator]
    generate_name
  end

  def generate_char
    ('A'..'Z').to_a.sample
  end

  def generate_num
    rand(10)
  end

  def generate_name
    if @name_generator
      @name = @name_generator.call
    else
      @name = "#{generate_char}#{generate_char}"\
        "#{generate_num}#{generate_num}#{generate_num}"
    end
    error?
    @@registry << @name
  end

  def error?
    if !(@name =~ /[[:alpha:]]{2}[[:digit:]]{3}/) || @@registry.include?(name)
      raise NameCollisionError, 'There was a problem generating the robot name!'
    end
  end
end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
generator = -> { 'AA111' }
robot_2 = Robot.new(name_generator: generator)
puts "My pet robot's name is #{robot_2.name}, but we usually call him sparky."
robot_3 = Robot.new(name_generator: generator)
puts "My pet robot's name is #{robot_3.name}, but we usually call him sparky."

