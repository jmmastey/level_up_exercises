class NameCollisionError < RuntimeError
end

class Robot
  attr_accessor :name

  class << self
    attr_accessor :registry
  end
  @registry = []

  def initialize(args = {})
    @name_generator = args[:name_generator] || method(:generate_random_name)

    @name = @name_generator.call

    raise NameCollisionError, name_generation_error if name_invalid?(name)
    self.class.registry << name
  end

  def generate_random_name
    generate_char = -> { ('A'..'Z').to_a.sample }
    generate_num = -> { rand(10) }
    @name = "#{generate_char.call}#{generate_char.call}"
    @name += "#{generate_num.call}#{generate_num.call}#{generate_num.call}"
  end
end

def name_generation_error
  puts 'There was a problem generating the robot name!'
end

def name_wrong_format?(name)
  !(name =~ /[[:alpha:]]{2}[[:digit:]]{3}/)
end

def name_already_exists?(name)
  self.class.registry.include?(name)
end

def name_invalid?(name)
  name_wrong_format?(name) || name_already_exists?(name)
end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
generator = -> { 'AA111' }
Robot.new(name_generator: generator)
Robot.new(name_generator: generator)
