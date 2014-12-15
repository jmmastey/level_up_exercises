class Robot
  attr_accessor :name

  class NameCollisionError < RuntimeError
    def initialize(message = "Name already exists in robot registry!")
      super
    end
  end

  class InvalidNameError < RuntimeError
    def initialize(message = "Invalid name for a robot! How rude!")
      super
    end
  end

  def self.registry
    @registry ||= []
  end

  def initialize(args = {})
    @name_generator = args[:name_generator] || name_generator

    @name = @name_generator.call
    validate_robot

    Robot.registry << @name
  end

  def name_generator
    -> { "#{generate_chars(2)}#{generate_nums(3)}" }
  end

  def generate_chars(n = 1)
    n.times.inject("") { |chars| chars + ('A'..'Z').to_a.sample }
  end

  def generate_nums(n = 1)
    n.times.inject("") { |nums| nums + rand(10).to_s }
  end

  def validate_robot
    raise InvalidNameError unless valid_name?
    raise NameCollisionError if Robot.registry.include?(name)
  end

  def valid_name?
    name =~ /[[:alpha:]]{2}[[:digit:]]{3}/
  end
end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
# generator = -> { 'AA111' }
# Robot.new(name_generator: generator)
# Robot.new(name_generator: generator)
