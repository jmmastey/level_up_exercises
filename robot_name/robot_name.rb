class NameCollisionError < RuntimeError; end

class Robot
  
  attr_accessor :name

  @@registry

  def initialize(args = {})
    @@registry ||= []
    @name = (args[:name_generator] && args[:name_generator].call) || generate_robot_name
    add_robot_to_registry
  end

  def self.get_registered
    @@registry
  end

  private

  def add_robot_to_registry
    raise NameCollisionError, "Improper robot name!" unless proper_name?
    @@registry << @name unless robot_registered?
  end

  def proper_name?
    @name =~ /[[:alpha:]]{2}[[:digit:]]{3}/
  end

  def robot_registered?
    @@registry.include?(@name)
  end

  def generate_robot_name
    "#{generate_char(2)}#{generate_num(3)}"
  end

  def generate_char(length=1)
    length.times.map { ('A'..'Z').to_a.sample }.join("")
  end

  def generate_num(length=1)
    length.times.map { rand(10) }.join("")
  end
end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

generator = -> { 'AA111' }
Robot.new(name_generator: generator)
Robot.new(name_generator: generator)

puts "Robots Registered:"
puts Robot.get_registered
