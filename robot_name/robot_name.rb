require_relative 'robot_factory'

robot_factory = RobotFactory.new

robot_a = robot_factory.create_robot
puts "My pet robot's name is #{robot_a.name}, but we usually call him sparky I."

robot_b = robot_factory.create_robot
puts "My pet robot's name is #{robot_b.name}, but we usually call him sparky II."

# Errors!
#robot_factory.create_robot('AA111')
#robot_factory.create_robot('AA111')
