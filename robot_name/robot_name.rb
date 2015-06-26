class NameCollisionError < RuntimeError
  def message
    'There was a problem generating the robot name!'
  end
end

class NameFormatError < RuntimeError
  def message
    'The robot name was not in the correct format.'
  end
end

class RobotRegistry
  attr_accessor :names

  def initialize
    @names = []
  end

  def add(name)
    if name.start_with?('ERROR: ')
      puts "The name '#{name[7..name.length]}' was not added to the repository."
    else
      @names << name
    end
  end
end

class Robot
  attr_accessor :name, :generator, :registry

  def apply_name
    @name = generator[:name].call
  end

  def random_name_generator
    generate_char = -> { ('A'..'Z').to_a.sample }
    generate_num = -> { rand(10) }

    alpha = "#{generate_char.call}#{generate_char.call}"
    numeric = "#{generate_num.call}#{generate_num.call}#{generate_num.call}"
    @name = alpha + numeric
  end

  def validate_generated_name
    raise NameFormatError unless name =~ /[[:alpha:]]{2}[[:digit:]]{3}/
    raise NameCollisionError if registry.names.include?(name)
  end

  def error_output(e)
    puts "#{e.message} (#{e} with #{name})"
  end

  def name_output
    puts "My pet robot's name is #{name}, but we usually call him sparky."
  end

  def generate_robot_name
    apply_name if generator[:name]
    random_name_generator unless generator[:name]
  end

  def validate_robot_name
    begin
      validate_generated_name
      name_output
    rescue StandardError => e
      error_output(e)
      @name = "ERROR: #{name}"
    end
  end

  def initialize(registry, generator={})
    @generator = generator
    @registry = registry

    generate_robot_name
    validate_robot_name
  end
end

registry = RobotRegistry.new

robot = Robot.new(registry)
registry.add(robot.name)

puts '---------------------------'

generator = -> { 'CHAPPIE' }
robot = Robot.new(registry, name: generator)
registry.add(robot.name)

puts '---------------------------'

generator = -> { 'AA111' }
robot = Robot.new(registry, name: generator)
registry.add(robot.name)

puts '---------------------------'

generator = -> { 'AA111' }
robot = Robot.new(registry, name: generator)
registry.add(robot.name)
