NameCollisionError = Class.new(RuntimeError)
NameInvalidError = Class.new(RuntimeError)

class Robot
  attr_accessor :name

  VALID_NAME = /^[[:alpha:]]{2}[[:digit:]]{3}$/
  INVALID_NAME_ERROR = 'The robot name is not valid!'
  NAME_EXISTS_ERROR = 'The robot name already exists!'
  CHARS_IN_NAME = 2
  DIGITS_IN_NAME = 3

  def initialize(args = {})
    @@registry ||= []
    @name_generator = args[:name_generator]
    @name = assign_name
    assert_valid_name
    add_name_to_registry
  end

  def assign_name
    if @name_generator
      @name_generator.call
    else
      generate_new_name
    end
  end

  def generate_new_name
    "#{character * CHARS_IN_NAME}#{number * DIGITS_IN_NAME}"
  end

  def assert_valid_name
    raise NameCollisionError, INVALID_NAME_ERROR unless name =~ VALID_NAME
    raise NameCollisionError, NAME_EXISTS_ERROR if @@registry.include?(name)
  end

  def add_name_to_registry
    @@registry << @name
  end

  private

  def character
    generate_char = -> { ('A'..'Z').to_a.sample }
    generate_char.call
  end

  def number
    generate_num = -> { rand(10).to_s }
    generate_num.call
  end
end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
# generator = -> { 'AA111' }
# Robot.new(name_generator: generator)
# Robot.new(name_generator: generator)
