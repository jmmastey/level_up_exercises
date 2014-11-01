class NameCollisionError < RuntimeError; end
class DuplicateNameError < RuntimeError; end

# Class that generates a robot name or takes the given name
class Robot
  attr_accessor :name
  NAME_COLLISION_ERROR = 'There was a problem generating the robot name!'
  DUPLICATE_NAME_ERROR = 'The robot name has already been used!'

  @@registry = []

  def initialize(name = '')
    @name = create_name(name)
    validate_name(@name)
    @@registry << @name
  end

  private

  def create_name(name)
    name.empty? ? generate_name : name
  end

  def validate_name(name)
    fail NameCollisionError, NAME_COLLISION_ERROR unless
    name =~ /[[:alpha:]]{2}[[:digit:]]{3}/
    fail DuplicateNameError, DUPLICATE_NAME_ERROR if @@registry.include?(name)
  end

  def generate_name
    name = ''
    2.times { name << generate_char }
    3.times { name << generate_number }
    name
  end

  def generate_char
    ('A'..'Z').to_a.sample
  end

  def generate_number
    rand(10).to_s
  end

  def to_s
    "My pet robot's name is #{@name}, but we usually call him sparky."
  end
end

robot = Robot.new
puts robot

# Name collision trigger
# robot = Robot.new('A111')
# puts robot

robot =  Robot.new('AA111')
puts robot

# Duplicate name error trigger
# robot =  Robot.new('AA111')
# puts robot
