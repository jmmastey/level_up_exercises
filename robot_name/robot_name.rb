class NameCollisionError < RuntimeError; end

class Robot
  attr_accessor :name

  VALID_NAME =  /^[[:alpha:]]{2}[[:digit:]]{3}$/
  ERRORMSG = 'There was a problem generating the robot name!'

  def initialize(args = {})
    @registry ||= []
    @name_generator = args[:name_generator]
    @name = assign_name
    valid_name_check
  end

  def assign_name
    if @name_generator
      @name_generator.call
    else
      generate_new_name
    end
  end

  def generate_new_name
    "#{character * 2}#{number * 3}"
  end

  def valid_name_check
    raise NameCollisionError, ERRORMSG unless name =~ VALID_NAME
    raise NameCollisionError, ERRORMSG if @registry.include?(name)
    @registry << @name
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
# generator = -> { 'AaA11111' }
# Robot.new(name_generator: generator)
# Robot.new(name_generator: generator)
