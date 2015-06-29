class RobotFactory
  attr_accessor :generator, :validator, :registry

  def initialize(generator, validator, registry)
    @generator = generator
    @validator = validator
    @registry = registry
  end

  def create_robot(options = {})
    name = get_robot_name(options)
    validator.validate_name(name, registry)
  rescue StandardError => e
    report_creation_error(e, name)
  else
    create_new_robot_in_registry(name)
  end

  private

  def create_new_robot_in_registry(name)
    robot = Robot.new(name)
    registry.add_name(robot.name)
    report_robot_creation(robot.name)
    robot
  end

  def get_robot_name(options)
    return options[:name] if options[:name]
    generator.random_name
  end

  def report_robot_creation(name)
    puts "Robot named #{name} successfully created."
  end

  def report_creation_error(e, name)
    puts "#{e.message} (#{e} with #{name})"
  end
end
