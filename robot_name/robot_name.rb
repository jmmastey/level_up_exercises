class NameCollisionError < RuntimeError; end

class Robot
  attr_accessor :name

  def generate_char 
    ('A'..'Z').to_a.sample
  end
  
  def generate_num
    rand(10) 
  end

  def name_generator
    if @name_generator
      @name = @name_generator.call
    else
      @name = "#{generate_char}#{generate_char}#{generate_num}#{generate_num}#{generate_num}"
    end
  end

  def is_error?
    if !(@name =~ /[[:alpha:]]{2}[[:digit:]]{3}/) || @@registry.include?(name)
      raise NameCollisionError, 'There was a problem generating the robot name!'
    end
  end

  def initialize(args = {})
    @@registry ||= []
    @name_generator = args[:name_generator]
    @name = name_generator 
    is_error?
    @@registry << @name
  end
end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
generator = -> { 'AA111' }
Robot.new(name_generator: generator)
Robot.new(name_generator: generator)

