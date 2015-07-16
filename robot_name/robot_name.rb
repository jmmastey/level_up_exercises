InvalidNameError = Class.new(RuntimeError)
NameCollisionError = Class.new(RuntimeError)

class RobotNameRegistry
  @names = []

  def self.add_name(name)
    @names << name if self.valid?(name) && self.unique?(name)
  end

  def self.valid?(name)
    unless name =~ /[[:alpha:]]{2}[[:digit:]]{3}/
      raise InvalidNameError, 'The given/generated name is invalid.'
    end
    true
  end

  def self.unique?(name)
    if @names.include? name
      raise NameCollisionError, "The given/generated name already exists."
    end
    true
  end
end

class Robot
  attr_accessor :name

  GEN_CHAR = -> { ('A'..'Z').to_a.sample }
  GEN_NUM = -> { rand(10) }

  def initialize(args = {})
    @name_generator = args[:name_generator]
    give_name
    add_name_to_registry
  end

  def generate_name
    # This method will always create a valid name.
    name = ""
    2.times { name += GEN_CHAR.call }
    3.times { name += GEN_NUM.call.to_s }
    name
  end

  def give_name
    @name = @name_generator ? @name_generator.call : generate_name
  end

  def add_name_to_registry
    RobotNameRegistry.add_name(@name)
  end
end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
# Test duplicates
# generator = -> { 'AA111' }
# Robot.new(name_generator: generator)
# Robot.new(name_generator: generator)

# Test invalid name
# generator = -> { 'AAA11' }
# Robot.new(name_generator: generator)
