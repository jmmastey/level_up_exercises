class DuplicateName < RuntimeError; end
class InvalidName < RuntimeError; end

class Registry
  @robot_names = []

  def self.check_for_duplicate(name)
    if @robot_names.include?(name)
      raise DuplicateName, 'There was a problem generating the robot name!'
    end
  end

  def self.add_name(name)
    check_for_duplicate(name)
    @robot_names << name
  end
end

class Robot
  attr_accessor :name

  CHAR_GENERATOR = -> { ('A'..'Z').to_a.sample }
  NUM_GENERATOR = -> { rand(10) }

  def initialize(generator = nil)
    @name = generator ? generator.call : generate_name
    validate_name
    Registry.add_name(@name)
  end

  def validate_name
    is_invalid = !(name =~ /[[:alpha:]]{2}[[:digit:]]{3}/)
    raise InvalidName, 'Invalid name' if is_invalid
  end

  def generate_name
    @name = ""
    2.times { @name << CHAR_GENERATOR.call }
    3.times { @name << NUM_GENERATOR.call.to_s }
    @name
  end
end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
# generator = -> { 'AA111' }
# Robot.new(generator)
# Robot.new(generator)

# generator = -> { 'AA11' }
# Robot.new(generator)
