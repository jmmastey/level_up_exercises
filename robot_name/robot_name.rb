class InvalidNameError < RuntimeError; end

class Robot
  attr_accessor :name

  @@registry = []
  @@name_schema = /[[:alpha:]]{2}[[:digit:]]{3}/

  def initialize(args = {})
    @name_generator = args[:name_generator] || method(:generate_name)

    @name = @name_generator.call

    fail InvalidNameError, "A robot cannot be created with the name '#{name}'" unless name =~ @@name_schema
    fail NameCollisionError, "A robot has already been created with the name '#{name}!"  if @@registry.include?(name)
    
    register_name(@name)
  end

  def generate_name
    name  = ""
    2.times { name += random_char }
    3.times { name += random_num.to_s }
    name
  end

  def random_char
    ('A'..'Z').to_a.sample
  end

  def random_num
    rand(10)
  end

private

  def register_name(name)
    @@registry << name
  end
end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
# generator = -> { 'AA111' }
# puts Robot.new(name_generator: generator).name
# puts Robot.new(name_generator: generator).name
