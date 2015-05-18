require './name_input_error.rb'
require './registry.rb'
require './robot.rb'
require './name_generator.rb'

class RobotCreator
  REG_EXP_NAME =  /[[:alpha:]]{2}[[:digit:]]{3}/
  NAME_INPUT_ERROR = "There was a problem with the user's robot name!"

  def initialize
    @robot_list = Registry.new
  end

  def create_robots(number_of_robots, *arg)
    (0...number_of_robots).each do |i|
      robot_name = arg[i] || NameGenerator.new.generate_name
      validate_input_name(robot_name)
      @robot_list.check_duplicate(robot_name)
      @robot_list.names << Robot.new(robot_name).name
    end
  end

  def validate_input_name(name)
    raise NameInputError, NAME_INPUT_ERROR unless name =~ REG_EXP_NAME
  end
end

robot_manager = RobotCreator.new
robot_manager.create_robots(13)
robot_manager.create_robots(2, "AA111", "AA111")
