class NameCollisionError < RuntimeError; end
class InvalidFormatError < RuntimeError; end

# Generates robot's name
class Robot
  attr_accessor :name

  def initialize(args = {})
    @@registry ||= []
    @name_generator = args[:name_generator]
  end

  def name
    if @name_generator
      @name = @name_generator.call
      fail InvalidFormatError, 'Not supported format' unless pattern_check?
    else
      generate_name
    end
    repeat_check
  end

  def random_num
    rand(10)
  end

  def random_char
    ('A'..'Z').to_a.sample
  end

  def generate_name
    str_arr = []
    (1..5).each do |i|
      str_arr << (i == 1 || i == 2 ? random_char : random_num.to_s)
    end
    @name = str_arr.join
  end

  def pattern_check?
    @name =~ /[[:alpha:]]{2}[[:digit:]]{3}/
  end

  def repeat_check
    if @@registry.include?(@name)
      fail NameCollisionError, 'There was a problem generating the robot name!'
    end
    @@registry << @name
    @name
  end
end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
generator = -> { 'AB111' }
puts "My second robot's name is #{Robot.new(name_generator: generator).name}"
puts "My third robot's name is #{Robot.new(name_generator: generator).name}"
