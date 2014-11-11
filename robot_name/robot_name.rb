class NameCollisionError < RuntimeError; end
class InvalidNameFormatError < RuntimeError; end

class Robot
  attr_accessor :name

  def initialize(args = {})
    @@registry ||= []
    @name_generator = args[:name_generator]
  end

  def name
    if @name_generator
      @name = @name_generator.call
      fail InvalidNameFormatError, 'Name is invalid.'  unless valid_format?
    else
      generate_name
    end
    repeat_check
  end

  def generate_name
    char_name = 2.times.map { generate_char }.join
    num_name = 3.times.map { generate_num }.join
    @name = "#{ char_name }#{ num_name }"
  end

  def generate_char
    ('A'..'Z').to_a.sample
  end

  def generate_num
    rand(10)
  end

  def valid_format?
    @name =~ /^[[:alpha:]]{2}[[:digit:]]{3}/
  end

  def repeat_check
    unless !(@@registry.include?(@name))
      fail NameCollisionError, 'There was a problem generating the robot name!'
    end
    @@registry << @name
    @name
  end
end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."
# Errors!
generator = -> { 'AA111' }
puts "My second robot name is #{Robot.new(name_generator: generator).name}"
puts "My third robot name is #{Robot.new(name_generator: generator).name}"
