InvalidNameError = Class.new(RuntimeError)
NameCollisionError = Class.new(RuntimeError)

class Robot
  attr_accessor :name

  @@registry = []

  GEN_CHAR = -> { ('A'..'Z').to_a.sample }
  GEN_NUM = -> { rand(10) }

  def initialize(args = {})
    @name_generator = args[:name_generator]
    if @name_generator
      given_name = @name_generator.call
      @name = given_name if valid?(given_name) && unique?(given_name)
    else
      @name = generate_name
    end
    add_name_to_registry(@name)
  end

  def valid?(name)
    unless (name =~ /[[:alpha:]]{2}[[:digit:]]{3}/)
      raise InvalidNameError, 'The given/generated name is invalid.'
    end
    true
  end

  def unique?(name)
    if @@registry.include? name
      raise NameCollisionError, "The given/generated name already exists."
    end
    true
  end

  def generate_name
    # This method will always create a valid name.
    name = ""
    2.times { name += GEN_CHAR.call }
    3.times { name += GEN_NUM.call.to_s }
    name
  end

  def add_name_to_registry(name)
    @@registry << name
  end
end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# # Errors!
# generator = -> { 'AA111' }
# Robot.new(name_generator: generator)
# Robot.new(name_generator: generator)