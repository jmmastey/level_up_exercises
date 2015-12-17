require_relative 'errors'
require_relative 'registry'

class Robot
  VALID_NAME_REGEX = /[[:alpha:]]{2}[[:digit:]]{3}/
  attr_accessor :name

  def initialize(args = {})
    @registry ||= RobotRegistry.registry
    @name_generator = args[:name_generator]
    @name = prepare_name
    check_name

    @registry << @name
  end

  private

  def prepare_name
    @name_generator ? @name_generator.call : generate_new_name
  end

  def generate_char
    [*'A'..'Z'].sample
  end

  def generate_num
    rand(10)
  end

  def generate_new_name
    "#{generate_char}#{generate_char}" \
    "#{generate_num}#{generate_num}#{generate_num}"
  end

  def check_name
    raise NameInvalidError unless name =~ VALID_NAME_REGEX
    raise NameCollisionError if @registry.include?(name)
  end
end

# generator = -> {'bb121'}
# robot = Robot.new(name_generator: generator)
# robot_registry = RobotRegistry.new
robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
generator = -> { 'AA111' }
Robot.new(name_generator: generator)
Robot.new(name_generator: generator)
