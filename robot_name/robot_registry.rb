class InvalidNameError < Exception
end

class NameExistsError < Exception
end

class RobotRegistry
  attr_accessor :registry

  ERROR_INVALID_NAME  = "Invalid robot name."
  ERROR_ROBOT_EXISTS  = "Robot name already registered."

  VALID_ROBOT_NAME_REGEX = /[[:alpha:]]{2}[[:digit:]]{3}/

  def initialize
    @registry = []
  end

  def get_registered_robots
    registry
  end

  def add_robot_to_registry(name)
    raise InvalidNameError, ERROR_INVALID_NAME unless proper_name?(name)
    raise NameExistsError, ERROR_ROBOT_EXISTS << " [#{name}]" if robot_registered?(name)
    registry << name
  end

  def proper_name?(name)
    name =~ VALID_ROBOT_NAME_REGEX
  end

  def robot_registered?(name)
    registry.include?(name)
  end
end
