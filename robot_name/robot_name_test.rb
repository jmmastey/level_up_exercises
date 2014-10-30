require_relative 'robot_name'

registry = RobotNameRegistry.new

robot = Robot.new(registry)
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
generator = -> { 'AA111' }
Robot.new(registry, name_generator: generator)
Robot.new(registry, name_generator: generator)
