class NameCollisionError < RuntimeError; end;

class RobotNameRegistry
  def initialize
    @@names = []
  end

  def add(name)
    @@names << name
  end

  def self.new_robot_name
    new_name = generate_name
    until is_unique_name?(new_name)
      new_name = generate_name
    end

    add(new_name)
    new_name
  end

  def is_unique_name?(name)
    !@@names.include?(name)
  end

  def generate_name
    "test"
    # " #{generate_char.call}#{generate_char.call}#{generate_num.call}#{generate_num.call}#{generate_num.call}"
  end

  def generate_char
    -> { ('A'..'Z').to_a.sample }
  end

  def generate_num
    -> { rand(10) }
  end
end

class Robot
  attr_accessor :name

  def initialize(args = {})
    @name = RobotNameRegistry.new_robot_name
  end

end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
# generator = -> { 'AA111' }
# Robot.new(name_generator: generator)
# Robot.new(name_generator: generator)

