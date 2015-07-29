require_relative 'exceptions'

class Robot
  attr_accessor :registry

  @@registry ||= []
  class RobotName < Robot
    attr_accessor :name

    def initialize(args = {})
      @name_generator = args[:name_generator]
      @name = @name_generator.call unless @name_generator.nil?
      create_name(2, 3) unless @name
      check_name
    end

    def random_ascii(string = "", num, char)
      num.times do
        string += ('A'..'Z').to_a.sample if char
        string += rand(10).to_s unless char
      end
      string
    end

    def create_name(num_char, num_dig)
      char = random_ascii(num_char, true)
      digit = random_ascii(num_dig, false)
      @name = char + digit
    end

    def name_structure?
      @name =~ /[[:alpha:]]{2}[[:digit:]]{3}/
    end

    def check_name
      if !(name_structure?) || @@registry.include?(@name)
        raise NameCollisionError, 'There was a problem generating the name'
      end
      @@registry << @name
    end
  end
end

robot = Robot::RobotName.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky"
generator = -> { 'AA111' }
robot1 = Robot::RobotName.new(name_generator: generator)
robot1 = Robot::RobotName.new(name_generator: generator)

puts "My pet robot's name is #{robot1.name}, but we usually call him sparky."

# Errors!
# generator = -> { 'AA111' }
# Robot.new(name_generator: generator)
