class InvalidNameError < RuntimeError; end
class NameCollisionError < RuntimeError; end

class Robot
  attr_accessor :name
  INVALID_NAME_ERROR_MSG = 'Invalid name for the robot!'
  COLLISION_ERROR_MSG = 'There was a collision generating the robot name!'

  def initialize(args = {})
    @@registry ||= []
    if args[:name_generator]
      @name = args[:name_generator].call
    else
      @name = generate_name
    end

    validate_name
    @@registry << @name
  end

  def generate_name
    "#{random_char}#{random_char}#{random_num}#{random_num}#{random_num}"
  end

  def random_char
    ('A'..'Z').to_a.sample
  end

  def random_num
    rand(10)
  end

  def validate_name
    raise InvalidNameError, INVALID_NAME_ERROR_MSG unless valid_name?
    raise NameCollisionError, COLLISION_ERROR_MSG if duplicate_name?
  end

  def valid_name?
    @name =~ /[[:alpha:]]{2}[[:digit:]]{3}/
  end

  def duplicate_name?
    @@registry.include?(name)
  end
end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

generator = -> { 'AN111' }
Robot.new(name_generator: generator)
Robot.new(name_generator: generator)
