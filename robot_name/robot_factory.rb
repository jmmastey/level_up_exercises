class RobotFactory
  attr_accessor :generator, :validator, :registry

  def initialize(generator, validator, registry)
    @generator = generator
    @validator = validator
    @registry = registry
  end

  def create_robot(options = {})
    name = give_robot_name(options)
    check_robot_name(name)
  end

  private

  def create_new_robot_in_registry(name)
    robot = Robot.new(name)
    registry.add_name(robot.name)
    report_robot_creation(robot.name)
    robot
  end

  def give_robot_name(options)
    name = options[:name] if options[:name]
    name = generator.random_name unless options[:name]
    name
  end

  def check_robot_name(name)
    begin
      validator.validate_name(name, registry)
    rescue StandardError => e
      report_creation_error(e, name)
    else
      create_new_robot_in_registry(name)
    end
  end

  def report_robot_creation(name)
    puts "Robot named #{name} successfully created."
  end

  def report_creation_error(e, name)
    puts "#{e.message} (#{e} with #{name})"
  end
end
