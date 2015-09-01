require_relative "Robot"

registry  = RobotRegistry.new
robot     = Robot.new

registry.add_robot_to_registry(robot.name)
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

puts "Robots Registered:"
puts registry.get_registered_robots.inspect

generator = -> { 'AA111' }
puts "\n!! Assembling AutoBots !!\n"
(1..2).each do |robot|
  auto_bot = Robot.new(name_generator: generator)
  registry.add_robot_to_registry(auto_bot.name)

  puts "Robots Registered:"
  puts registry.get_registered_robots.inspect
end
