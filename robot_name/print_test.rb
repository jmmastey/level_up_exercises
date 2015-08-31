require_relative "Robot"

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

generator = -> { 'AA111' }
Robot.new(name_generator: generator)
Robot.new(name_generator: generator)

puts "Robots Registered:"
puts RobotRegistry.get_registered_robots.inspect