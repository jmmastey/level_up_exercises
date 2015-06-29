require_relative 'errors'
require_relative 'robot'
require_relative 'name_generator'
require_relative 'name_validator'
require_relative 'robot_registry'
require_relative 'robot_factory'

generator = NameGenerator.new
validator = NameValidator.new
registry = RobotRegistry.new

factory = RobotFactory.new(generator, validator, registry)

# Will generate a name for this robot since no name was provided.
factory.create_robot

# Will attempt to create a robot with this name, but will fail
# due to format violation.
factory.create_robot('CHAPPIE')

# Will create the first robot with name; second robot creation will fail.
factory.create_robot('AA111')
factory.create_robot('AA111')

# Demonstrates only the valid robot names were stored in the registry.
puts registry.names
