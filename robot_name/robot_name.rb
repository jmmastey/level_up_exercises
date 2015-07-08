class NameCollisionError < RuntimeError; end

class Robot
  attr_accessor :name

  @@registry

  def initialize(args = {})
    @@registry ||= []
    @name_generator = args[:name_generator]

    if @name_generator
      @name = @name_generator.call
    else
      @name = generate_name
    end

    check_valid_name(name)
    check_new_name(name)

    @@registry << @name
  end

  private

  def generate_name
    "".tap do |name|
      2.times { name << generate_char }
      3.times { name << generate_num.to_s }
    end
  end

  def generate_char
    characters = ('A'..'Z').to_a
    characters.sample
  end

  def generate_num
    rand(10)
  end

  def check_valid_name(name)
    if (name =~ /\A[[:alpha:]]{2}[[:digit:]]{3}\Z/).nil?
      raise NameError, "Name is not valid"
    end
  end

  def check_new_name(name)
    if @@registry.include?(name)
      raise NameCollisionError, 'There was a problem generating the robot name!'
    end
  end
end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
generator = -> { 'AA111' }
robot = Robot.new(name_generator: generator)
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."
Robot.new(name_generator: generator)
