class NameCollisionError < RuntimeError; end

class Robot
  attr_accessor :name
  @@registry ||= []

  def initialize(name_generator = method(:generate_new_name))
    @name = name_generator.call
    validate_name
  end

  def generate_new_name
    alphabet = ('A'..'Z').to_a

    (2.times.map { alphabet.sample } + 3.times.map { rand(10) }).join
  end

  def validate_name
    if valid_name? && !name_in_registry?
      @@registry << name
    else
      raise NameCollisionError, "There was a problem generating the robot name!"
    end
  end

  def valid_name?
    name =~ /[[:alpha:]]{2}[[:digit:]]{3}/
  end

  def name_in_registry?
    @@registry.include? name
  end
end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
generator = -> { 'AA111' }
Robot.new(generator)
Robot.new(generator)
