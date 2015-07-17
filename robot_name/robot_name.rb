class NameCollisionError < RuntimeError; end

class Robot
  attr_accessor :name

  VALID_NAME_FORMAT  = /[[:alpha:]]{2}[[:digit:]]{3}/
  NAME_COLLISION_MSG = 'There was a problem generating the robot name!'

  @@registry = []

  def initialize(args = {})
    @name_generator = args[:name_generator]
    @name = @name_generator ? @name_generator.call : generate_rand_name
    raise NameCollisionError, NAME_COLLISION_MSG if name_collision
    @@registry << @name
  end

  private

  def generate_rand_name
    rand_chars = "#{generate_char}#{generate_char}"
    rand_num   = "#{generate_num}#{generate_num}#{generate_num}"
    rand_chars + rand_num
  end

  def name_collision
    !(@name =~ VALID_NAME_FORMAT) || @@registry.include?(@name)
  end

  def generate_char
    ('A'..'Z').to_a.sample
  end

  def generate_num
    rand(10)
  end
end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
# generator = -> { 'AA111' }
# Robot.new(name_generator: generator)
# Robot.new(name_generator: generator)
