class NameCollisionError < RuntimeError
  def to_s
    "There was a problem generating the robot name!"
  end
end

class Robot
  attr_reader :name

  @@registry

  def initialize(args = {})
    @@registry ||= []

    name_generator = args[:name_generator]
    @name = (name_generator && name_generator.call) || generate_name
    raise NameCollisionError if !(valid_name?(name)) || @@registry.include?(name)
    @@registry << @name
  end

  def generate_name
    "#{generate_char}#{generate_char}#{generate_num}#{generate_num}#{generate_num}"
  end

  private

  def generate_char
    ('A'..'Z').to_a.sample
  end

  def generate_num
    rand(10)
  end

  def valid_name?(name)
    name =~ /[[:alpha:]]{2}[[:digit:]]{3}/
  end
end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
# generator = -> { 'AA111' }
# Robot.new(name_generator: generator)
# Robot.new(name_generator: generator)
