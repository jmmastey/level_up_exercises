class NameCollisionError < RuntimeError
  def initialize(error_msg = 'There was a problem generating the robot name!')
    super
  end
end

class Robot
  attr_reader :name

  @@registry = []

  def initialize(args = {})
    @name = args[:name_generator] ? args[:name_generator].call : generate_name
    check_for_errors
    @@registry << @name
  end
  
  private
  def check_for_errors
    raise NameCollisionError unless (name =~ /[[:alpha:]]{2}[[:digit:]]{3}/)
    raise NameCollisionError if @@registry.include?(name)
  end
  
  def generate_name
    name = 2.times.collect { generate_char } + 3.times.collect { generate_num }
    name.join
  end
  
  def generate_char
    ('A'..'Z').to_a.sample
  end
  
  def generate_num
    rand(10)
  end
end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
#generator = -> { 'AA111' }
#Robot.new(name_generator: generator)
#Robot.new(name_generator: generator)