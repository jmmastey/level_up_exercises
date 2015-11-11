class NameCollisionError < RuntimeError
  def self.failure
    raise 'There was a problem generating the robot name!'
  end
end

class Robot
  attr_accessor :name
  attr_reader :registry

  def initialize(args = {})
    @registry = args[:registry]
    @name = args[:name] || NameGenerator.new.generate_name(2, 3)

    add_to_registry(@registry)
  end

  private

  def add_to_registry(registry)
    if invalid_name?
      NameCollisionError.failure
    end
    registry.list << name
  end

  def invalid_name?
    !(name =~ /[[:alpha:]]{2}[[:digit:]]{3}/) || registry.include?(name)
  end
end

class NameGenerator
  def generate_name(num_chars, num_nums)
    name = ""
    num_chars.times do
      name += generate_char
    end
    num_nums.times do
      name += generate_num
    end

    name
  end

  private

  def generate_char
    [*'A'..'Z'].sample
  end

  def generate_num
    rand(10).to_s
  end
end

class Registry
  attr_accessor :list

  def initialize(args = {})
    @type = args[:type]
    @list = args[:list] || []
  end

  def include?(string)
    list.include?(string)
  end
end

robot_registry = Registry.new(type: "robot")
robot = Robot.new(registry: robot_registry)
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
robot_2 = Robot.new(registry: robot_registry, name: 'AA111')
puts "My pet robot's name is #{robot_2.name}, but we usually call him junky."

robot_3 = Robot.new(registry: robot_registry, name: 'AA111')
puts "My pet robot's name is #{robot_3.name}, but we usually call him junky."
