class NameCollisionError < RuntimeError; end

class Robot
  attr_accessor :name
  VALID_NAME = /[[:alpha:]]{2}[[:digit:]]{3}/
  @@registry ||= []

  def initialize(args = {})
    @name_generator = args[:name_generator]
    @name = make_name

    check_name  
  end

  def check_name
    raise NameCollisionError, 'There was a problem generating the robot name!' if invalid_name?
    @@registry << @name
  end

  def generate_char
    ('A'..'Z').to_a.sample
  end

  def generate_num
    rand(10)
  end

  def make_name
    if @name_generator
      @name = @name_generator.call
    else
      @name = "#{generate_char}#{generate_char}#{generate_num}#{generate_num}#{generate_num}"
    end
  end

  def invalid_name?
    !(name =~ VALID_NAME) || @@registry.include?(name)
  end
end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
# generator = -> { 'AA111' }
# Robot.new(name_generator: generator)
# Robot.new(name_generator: generator)
