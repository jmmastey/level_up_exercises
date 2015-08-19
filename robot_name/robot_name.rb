class NameCollisionError < RuntimeError; end

class Robot
  attr_accessor :name

  @@registry

  def initialize(args = {})
    @@registry ||= []
    @name_generator = args[:name_generator]

    if @name_generator
      addRobotToRegistry(@name_generator.call)
    else
      addRobotToRegistry
    end
  end

  def self.showRegistered
    puts @@registry
  end

  def addRobotToRegistry(robotName="")
    if robotName.empty?
      robotName   = "#{generateChar(2)}#{generateNum(3)}"
    end

    @name = robotName
    unless robotRegistered?(@name)
      raise NameCollisionError, "Problem with robot name! [#{@name}]" unless properName?(@name)
      @@registry << @name
    end
  end

  def generateChar(length=1)
    length.times.collect {('A'..'Z').to_a.sample}.join("")
  end

  def generateNum(length=1)
    length.times.collect {rand(10)}.join("")
  end

  def properName?(name) 
    name =~ /[[:alpha:]]{2}[[:digit:]]{3}/
  end

  def robotRegistered?(name)
    @@registry.include?(name)
  end
end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

generator = -> { 'AA111' }
Robot.new(name_generator: generator) 
Robot.new(name_generator: generator)

puts "Robots Registered:"
Robot.showRegistered
