class NameCollisionError < RuntimeError; end

class Robot
  attr_accessor :name

  @@registry

  def initialize(args = {})
    @@registry ||= []
    @name_generator = args[:name_generator]
    @name = @name_generator ? @name_generator.call : generate_new_name
    check_name

    @@registry << @name
  end

  def generate_char 
    ('A'..'Z').to_a.sample
  end

  def generate_num
    rand(10)
  end

  def generate_new_name
      "#{generate_char}#{generate_char}#{generate_num}#{generate_num}#{generate_num}"
  end

  def check_name
    if !(name =~ /[[:alpha:]]{2}[[:digit:]]{3}/) || @@registry.include?(name)
      raise NameCollisionError, 'There was a problem generating the robot name!' 
    end
  end
end

# generator = -> {'bb121'}
# robot = Robot.new(name_generator: generator)
robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
# generator = -> { 'AA111' }
# Robot.new(name_generator: generator)
# Robot.new(name_generator: generator)
