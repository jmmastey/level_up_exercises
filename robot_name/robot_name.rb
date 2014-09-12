class InvalidNameError < RuntimeError; end
class NameCollisionError < RuntimeError; end

class Robot
  attr_accessor :name

  ALPHACOUNT = 2
  DIGITCOUNT = 3
  REGISTRY = []
  SCHEMA = "[[:alpha:]]{#{ALPHACOUNT}}[[:digit:]]{#{DIGITCOUNT}}"
  NAME_SCHEMA = Regexp.new(SCHEMA)

  # TO-DO dynamic regex generation

  def initialize(args = {})
    @name_generator = args[:name_generator] || method(:generate_name)

    @name = @name_generator.call

    raise_name_mismatch_error unless name =~ NAME_SCHEMA
    raise_name_collision_error if REGISTRY.include?(name)

    register_name(@name)
  end

  def generate_name
    name  = ""
    ALPHACOUNT.times { name += random_char }
    DIGITCOUNT.times { name += random_num.to_s }
    name
  end

  def random_char
    ('A'..'Z').to_a.sample
  end

  def random_num
    rand(10)
  end

  private

  def raise_name_mismatch_error
    fail InvalidNameError, "A robot cannot be created with the name '#{name}'"
  end

  def raise_name_collision_error
    fail NameCollisionError, "A robot has already been created with the name '#{name}!"
  end

  def register_name(name)
    REGISTRY << name
  end
end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
# generator = -> { 'AA111' }
# puts Robot.new(name_generator: generator).name
# puts Robot.new(name_generator: generator).name
