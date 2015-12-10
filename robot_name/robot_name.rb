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

  def generate_name
    output = ""
    2.times { output << ('A'..'Z').to_a.sample }
    3.times { output << rand(10).to_s }
    output
  end

  def make_name
    if @name_generator
      @name = @name_generator.call
    else
      @name = generate_name
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
