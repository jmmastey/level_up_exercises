class NameCollisionError < RuntimeError; end
class InvalidNameError < RuntimeError; end

class Robot
  attr_accessor :name

  @@registry = []
  @@name_schema = /[[:alpha:]]{2}[[:digit:]]{3}/

  def initialize(args = {})
    @name_generator = args[:name_generator]

    if @name_generator
      @name = @name_generator.call
    else
      @name = generate_name
    end

    fail InvalidNameError, "A robot cannot be created with the name '#{name}'" unless name =~ @@name_schema
    fail NameCollisionError, "A robot has already been created with the name '#{name}!"  if @@registry.include?(name)
    @@registry << @name
  end

  def generate_name
    name = []
    2.times { name << random_char }
    3.times { name << random_num }
    name.join
  end

  def random_char
    ('A'..'Z').to_a.sample
  end

  def random_num
    rand(10)
  end
end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
#generator = -> { 'AA111' }
#puts Robot.new(name_generator: generator).name
#puts Robot.new(name_generator: generator).name
