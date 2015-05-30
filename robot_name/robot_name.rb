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
    rname = [*'A'..'Z'].sample(2)
    3.times { rname << rand(10) }
    rname.join
  end

  def name=(val)
    validate_name(val)
    @name = val
  end

  def validate_name(vname)
    if name_conflict?(vname)
      raise NameCollisionError, ERR[:conflict] + "#{vname}"
    end
    raise NameFormatError, ERR[:format] unless name_valid_format?(vname)
  end

  def name_valid_format?(vname)
    vname =~ /[A-Z]{2}[0-9]{3}/
  end

  def name_conflict?(vname)
    self.class.registry.include?(vname)
  end
end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
generator = -> { 'AA111' }
Robot.new(name_generator: generator)
Robot.new(name_generator: generator)
