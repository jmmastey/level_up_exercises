class NameCollisionError < RuntimeError
end

class Robot
  attr_accessor :name, :registry
  NAME_ERROR = 'There was a problem generating the robot name!'

  def initialize(_args = {})
    @registry ||= []
    @name = name_generator
    check_name
  end

  def name_generator
    (characters + numbers).join
  end

  def characters
    2.times.map { ('A'..'Z').to_a.sample }
  end

  def numbers
    3.times.map { ('0'..'9').to_a.sample }
  end

  def check_name
    raise NameCollisionError, NAME_ERROR unless
    (name =~ /[[:alpha:]]{2}[[:digit:]]{3}/) || registry.include?(name)
  end
end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
# generator = -> { 'AA111' }
# Robot.new(name_generator: generator)
# Robot.new(name_generator: generator)
