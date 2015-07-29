require_relative 'exceptions'

class Robot 
  attr_accessor :registry

  @@registry ||= []
  class RobotName < Robot
    attr_accessor :name

    def initialize(args = {})
      @name_generator = args[:name_generator]
      @name = @name_generator.call if @name_generator != nil
      create_name(2, 3) unless @name
      check_name
    end
  
    def create_name(num_char, num_dig)
      char = ""
      digit = ""
      num_char.times do 
        char += ('A'..'Z').to_a.sample
      end
      num_dig.times do 
        digit += rand(10).to_s
      end
      @name = char + digit
    end
  
    def check_name
      if !(@name =~ /[[:alpha:]]{2}[[:digit:]]{3}/) || @@registry.include?(@name)
        raise NameCollisionError, 'There was a problem generating the robot name #!'
      end
      @@registry << @name
    end
  end
end

robot = Robot::RobotName.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky"
generator = -> {'AA111'}
robot1 = Robot::RobotName.new(name_generator: generator)
robot1 = Robot::RobotName.new(name_generator: generator)

puts "My pet robot's name is #{robot1.name}, but we usually call him sparky."

# Errors!
# generator = -> { 'AA111' }
# Robot.new(name_generator: generator)
