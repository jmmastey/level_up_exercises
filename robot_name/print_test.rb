require_relative "robot"

robot = Robot.new()
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

puts "Robots Registered:"
puts Robot.registry.inspect

generator = -> { 'AA111' }
puts "\n!! Assembling AutoBots !!\n"
(1..2).each do |robot|
  auto_bot = Robot.new(name_generator: generator)

  puts "Robots Registered:"
  puts Robot.registry.inspect
end
