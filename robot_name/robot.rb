class DuplicateName < RuntimeError; end
class InvalidName < RuntimeError; end

class Robot
  attr_accessor :name

  @@robot_names = []

  CHAR_GENERATOR = -> { ('A'..'Z').to_a.sample }
  NUM_GENERATOR = -> { rand(10) }

  def self.robot_names
    @@robot_names
  end

  def valid?
    if !(name =~ /[[:alpha:]]{2}[[:digit:]]{3}/)
      raise InvalidName, 'Invalid robot name'
    elsif @@robot_names.include?(name)
      raise DuplicateName, 'There was a problem generating the robot name!'
    end
    true
  end

  def generate_name
    @name = ""
    3.times { @name << CHAR_GENERATOR.call }
    3.times { @name << NUM_GENERATOR.call.to_s }
  end

  def initialize(args = {})
    name_generator = args[:name_generator]

    if name_generator
      @name = name_generator.call
    else
      generate_name
    end

    @@robot_names << @name if valid?
  end
end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
# generator = -> { 'AA111' }
# Robot.new(name_generator: generator)
# Robot.new(name_generator: generator)
