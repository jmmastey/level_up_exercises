require_relative 'robot_name'

registry = RobotNameRegistry.new

# With Default options
sparky = Robot.new(registry)
puts "Robot name is #{sparky.name}, but we usually call him Sparky"

# Check name collisions
static_generator = lambda {'AA123'}
billy = Robot.new(registry, name_generator: static_generator)
# bobby = Robot.new(registry, name_generator: static_generator)

# Check different schema
static_generator = lambda {'AA1234'}
arthur = Robot.new(registry, name_generator: static_generator, schema: "[[:upper:]]{2}[[:digit:]]{4}")
p arthur.name