class NameCollisionError < RuntimeError; end

class Robot
  attr_accessor :name

  @@registry

  def initialize(args = {})
    @@registry ||= []
    @name_generator = args[:name_generator]

    if @name_generator
      add_robot_to_registry(@name_generator.call)
    else
      add_robot_to_registry
    end
  end

  def self.show_registered
    puts @@registry
  end

  def add_robot_to_registry(robotName="")
    if robotName.empty?
      robotName = "#{generate_char(2)}#{generate_num(3)}"
    end

    @name = robotName
    unless robot_registered?(@name)
      raise NameCollisionError, "Improper robot name!" unless proper_name?(@name)
      @@registry << @name
    end
  end

  def generate_char(length=1)
    length.times.map { ('A'..'Z').to_a.sample }.join("")
  end

  def generate_num(length=1)
    length.times.map { rand(10) }.join("")
  end

  def proper_name?(name) 
    name =~ /[[:alpha:]]{2}[[:digit:]]{3}/
  end

  def robot_registered?(name)
    @@registry.include?(name)
  end
end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

generator = -> { 'AA111' }
Robot.new(name_generator: generator) 
Robot.new(name_generator: generator)

puts "Robots Registered:"
Robot.show_registered
