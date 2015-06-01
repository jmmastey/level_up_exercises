class NameCollisionError < RuntimeError; end
class NameFormatError < RuntimeError; end

class Robot
  class << self
    attr_accessor :registry
  end
  @registry = []

  attr_accessor :name

  ERR = {
    conflict: 'Robot name already exists: ',
    format: 'Robot name format incorrect! (two capital letters, 3 numbers)',
  }

  def initialize(args = {})
    @name_generator = args[:name_generator] || method(:generator)

    @name = generate_name
    validate_name(name)

    self.class.registry << @name
  end

  def generate_name
    @name_generator.call
  end

  def generator
    name = [*'A'..'Z'].sample(2)
    3.times { name << rand(10) }
    name.join
  end

  def name=(val)
    validate_name(val)
    @name = val
  end

  def validate_name(name)
    raise NameCollisionError, name_err_msg(name) if name_conflict?(name)
    raise NameFormatError, ERR[:format] unless valid_name?(name)
  end

  def name_err_msg(name)
    ERR[:conflict] + "#{name}"
  end

  def valid_name?(name)
    name =~ /[A-Z]{2}[0-9]{3}/
  end

  def name_conflict?(name)
    self.class.registry.include?(name)
  end
end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
generator = -> { 'AA111' }
Robot.new(name_generator: generator)
Robot.new(name_generator: generator)
