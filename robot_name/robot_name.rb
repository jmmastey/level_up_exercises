RobotNamingError = Class.new(RuntimeError)
NameCollisionError = Class.new(RobotNamingError)
InvalidNameError = Class.new(RobotNamingError)

class Robot
  attr_accessor :name

  def initialize(args = {})
    @@registry ||= []
    @name_generator = args[:name_generator]
    generate_name(@name_generator)
  end

  def generate_name(name_generator)
    if name_generator
      @name = name_generator.call
    else
      @name = (0..1).map { ('a'..'z').to_a[rand(26)] }.join.upcase \
    + (0..2).map { rand(9) }.join
    end
    check_and_add_to_registry
  end

  def check_name_for_validity
    return @name if @name =~ /[[:alpha:]]{2}[[:digit:]]{3}/
    raise InvalidNameError, 'Invalid name #{name}!'
  end

  def check_name_for_collision
    return @name unless @@registry.include?(@name)
    raise NameCollisionError, 'Name already exits'
  end

  def check_and_add_to_registry
    check_name_for_validity
    check_name_for_collision
    @@registry << @name
  end
end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
# generator = -> { 'AA111' }
# Robot.new(name_generator: generator)
# Robot.new(name_generator: generator)
