require_relative 'robot'
require_relative 'robot_name_registry'

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
# Test duplicates
# generator = -> { 'AA111' }
# Robot.new(name_generator: generator)
# Robot.new(name_generator: generator)

# Test invalid name
# generator = -> { 'AAA11' }
# Robot.new(name_generator: generator)
