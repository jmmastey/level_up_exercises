class NameFormatError < RuntimeError; end

class Robot
  attr_accessor :name

  @@registry

  def initialize(args = {})
    @@registry ||= []
    @name = generate_name(args[:name])
  end

  def generate_name(robot_name = nil)
    robot_name = "#{generate_char}#{generate_num}" unless robot_name

    return generate_name if @@registry.include?(robot_name)

    unless robot_name =~ /^[A-Z]{2}[0-9]{3}$/
      raise NameFormatError, "Robot name \"#{robot_name}\" is wrong format!"
    end

    @@registry << robot_name

    robot_name
  end

  def generate_char
    ('A'..'Z').to_a.sample(2).join
  end

  def generate_num
    prng = Random.new
    prng.rand(100..999)
  end
end

robot = Robot.new
robot2 = Robot.new
robot3 = Robot.new(name: "AA111")
robot4 = Robot.new(name: "AA111")

puts "My pet robot's name is #{robot.name}, but we usually call him sparky."
puts "My pet robot's name is #{robot2.name}, but we usually call him sparky."
puts "My pet robot's name is #{robot3.name}, but we usually call him sparky."
puts "My pet robot's name is #{robot4.name}, but we usually call him sparky."
