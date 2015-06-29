class RobotFactory
  attr_accessor :generator, :validator, :registry

  def initialize(generator, validator, registry)
    @generator = generator
    @validator = validator
    @registry = registry
  end

  def create_robot(name = nil)
    name ||= generator.random_name
    validator.validate_name(name, registry)
  rescue StandardError => e
    report_creation_error(e, name)
  else
    robot = Robot.new(name)
    add_robot_to_registry(robot)
  end

  private

  def add_robot_to_registry(robot)
    registry.add_name(robot.name)
    report_robot_creation(robot.name)
    robot
  end

  def report_robot_creation(name)
    puts "Robot named #{name} successfully created."
  end

  def report_creation_error(e, name)
    puts "#{e.message} (#{e} with #{name})"
  end
end
