class NameCollisionError < RuntimeError; end

class Robot
  attr_accessor :name

  @@registry = []

  def initialize(name_generator = nil)
    @name_generator = name_generator || method(:default_name_generator)
    generate_name
  end

  private

  def generate_name
    @name = @name_generator.call
    raise NameCollisionError,
      'There was a problem generating the robot name!' unless valid?(@name) &&
      uniq?(@name)
    @@registry << @name
  end

  def default_name_generator
    @name = (2.times.map { ('A'..'Z').to_a.sample } +
             3.times.map { rand(10) }).join
  end

  def valid?(name)
    name =~ /[[:alpha:]]{2}[[:digit:]]{3}/
  end

  def uniq?(name)
    !@@registry.include?(name)
  end
end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
generator = -> { 'AA111' }
Robot.new(generator)
begin
  Robot.new(generator)
  puts "Faild, exception not raised"
rescue
  puts "Works, error called!!!"
end
