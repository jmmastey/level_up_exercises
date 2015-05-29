class NameCollisionError < RuntimeError; end

class Robot
  class << self
    attr_accessor :registry
  end
  @registry = []

  attr_accessor :name

  ERR = { name: 'There was a problem generating the robot name!' }

  def initialize(args = {})
    @name_generator = args[:name_generator] || method(:generator)

    @name = generate_name
    raise NameCollisionError, ERR[:name] unless valid?(name)

    self.class.registry << @name
  end

  def generate_name
    @name_generator.call
  end

  def generator
    rname = [*'A'..'Z'].sample(2)
    3.times { rname << rand(10) }
    rname.join
  end

  def name=(val)
    raise NameCollisionError, ERR[:name] unless valid?(val)
    @name = val
  end

  def valid?(vname)
    valid_name?(vname) && !name_conflict?(vname)
  end

  def valid_name?(vname)
    vname =~ /[[:alpha:]]{2}[[:digit:]]{3}/
  end

  def name_conflict?(vname)
    self.class.registry.include?(vname)
  end
end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
# generator = -> { 'AA111' }
# Robot.new(name_generator: generator)
# Robot.new(name_generator: generator)
