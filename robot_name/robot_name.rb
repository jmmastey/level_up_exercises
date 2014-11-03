class NameCollisionError < RuntimeError; end

class Robot
  attr_accessor :name

  VALID_NAME = /[[:alpha:]]{2}[[:digit:]]{3}/

  @@registry

  def initialize(args = {})
    @@registry ||= []
    @name_generator = args[:name_generator]
    assign_name
    add_to_registry
  end

  def assign_name
    if @name_generator
      @name = @name_generator.call
    else
      generate_new_name
    end
    assert_valid_name
  end

  def generate_new_name
    @name = "#{character}#{character}#{number}#{number}#{number}"
  end

  def assert_valid_name
    if !(name =~ VALID_NAME) || @@registry.include?(name)
      raise NameCollisionError, 'There was a problem generating the robot name!'
    end
  end

  def add_to_registry
    @@registry << @name
  end

  private

  def character
    generate_char = -> { ('A'..'Z').to_a.sample }
    generate_char.call
  end

  def number
    generate_num = -> { rand(10) }
    generate_num.call
  end
end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
# generator = -> { 'AA111' }
# Robot.new(name_generator: generator)
# Robot.new(name_generator: generator)
