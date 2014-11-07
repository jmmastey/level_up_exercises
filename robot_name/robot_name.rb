class NameCollisionError < RuntimeError; end

class Robot
  attr_accessor :name

  def initialize(args = {})
    @@registry ||= []
    @name_generator = args[:name_generator]
  end

  def robo_name
    if @name_generator
      @name = @name_generator.call
      repeat_check
    else
      generate_name
    end
  end

  def generate_name
    char_name = "#{ 2.times.map { generate_char }.join }"
    num_name = "#{ 3.times.map { generate_num }.join }"
    @name = "#{ char_name }#{ num_name }"
    repeat_check
  end

  def generate_char
    ('A'..'Z').to_a.sample
  end

  def generate_num
    rand(10)
  end

  def condition?
    !(@name =~ /[[:alpha:]]{2}[[:digit:]]{3}/) || @@registry.include?(@name)
  end

  def repeat_check
    fail NameCollisionError, 'There was a problem generating the robot name!' if condition?
    @@registry << @name
    @name
  end
end

robot = Robot.new
puts "My pet robot's name is #{robot.robo_name}, but we usually call him sparky."
# Errors!
generator = -> { 'AA111' }
puts "My second robot name is #{Robot.new(name_generator: generator).robo_name}"
puts "My third robot name is #{Robot.new(name_generator: generator).robo_name}"
