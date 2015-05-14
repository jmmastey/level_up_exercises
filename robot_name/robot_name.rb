class NameCollisionError < RuntimeError; end

class RobotNames
  attr_accessor :names
  def initialize
    @names = []
  end
end


class Robot
  attr_accessor :name
  NAME_ERROR = "There was a problem generating the robot name!"
  REG_EX = '[[:alpha:]]{2}[[:digit:]]{3}'

  def initialize(args = {})
    @registry ||= args[:used_names]
    @name_generator = args[:name_generator]
    assign_name
    bad_name = !(@name =~ /#{REG_EX}/) || @registry.include?(@name)
    raise NameCollisionError, NAME_ERROR if bad_name
    @registry << @name
  end

  def assign_name
    if @name_generator
      @name = @name_generator.call
    else
      generate_name
    end
  end

  def generate_name
    generate_char = -> { ('A'..'Z').to_a.sample }
    generate_num = -> { rand(10) }
    @name = "#{generate_char.call}#{generate_char.call}"
    @name += "#{generate_num.call}#{generate_num.call}#{generate_num.call}"
  end
end

used_names = RobotNames.new
robot = Robot.new(used_names: used_names.names)
used_names.names << robot
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
generator = -> { 'AA111' }
robot = Robot.new(name_generator: generator, used_names: used_names.names)
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."
robot = Robot.new(name_generator: generator, used_names: used_names.names)
