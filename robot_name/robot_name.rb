class NameCollisionError < RuntimeError; end

class Robot
  attr_accessor :name

  @@registry = []

  def initialize(name_generator = nil)
    @name_generator = name_generator
    @name = generate_name
    if is_valid?(@name) && is_uniq?(@name)
      @@registry << @name
    else
      raise NameCollisionError, 'There was a problem generating the robot name!' 
    end
  end

  private
  def generate_name
    if @name_generator
      @name = @name_generator.call
    else
      @name = "#{2.times.collect { generate_char }.join}" <<
        "#{3.times.collect { generate_num }.join}"
    end
  end

  def generate_num
    rand(10)
  end

  def generate_char
    ('A'..'Z').to_a.sample
  end

  def is_valid?(name)
    name =~ /[[:alpha:]]{2}[[:digit:]]{3}/
  end

  def is_uniq?(name)
    !@@registry.include?(name)
  end
end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
# generator = -> { 'AA111' }
# Robot.new(name_generator: generator)
# Robot.new(name_generator: generator)
