class NameFormatError < RuntimeError; end
class NameCollisionError < RuntimeError; end

class Robot
  attr_accessor :name

  def self.registry
    @registry ||= []
  end

  def initialize(args = {})
    @name = args[:name] ? register_name(args[:name]) : generate_name
  end

  def generate_name
    robot_name = "#{generate_char}#{generate_num}"

    return generate_name if name_exists?(robot_name)

    register_name(robot_name)
  end

  def register_name(robot_name)
    raise NameCollisionError, "Robot name \"#{robot_name}\" "\
                              "already exists!" if name_exists?(robot_name)

    raise NameFormatError, "Robot name \"#{robot_name}\" is wrong "\
                           "format!" unless robot_name =~ /^[A-Z]{2}[0-9]{3}$/

    self.class.registry << robot_name

    robot_name
  end

  def generate_char
    ('A'..'Z').to_a.sample(2).join
  end

  def generate_num
    nums = []
    (1..3).each do
      nums << rand(10)
    end
    nums.join
  end

  def name_exists?(robot_name)
    self.class.registry.include?(robot_name) ? true : false
  end
end

robot = Robot.new
robot2 = Robot.new
robot3 = Robot.new(name: "AA111")

puts "My pet robot's name is #{robot.name}, but we usually call him sparky."
puts "My pet robot's name is #{robot2.name}, but we usually call him sparky."
puts "My pet robot's name is #{robot3.name}, but we usually call him sparky."
