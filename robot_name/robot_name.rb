# require 'pry'
# require 'pry-nav'

class NameCollisionError < RuntimeError
  def to_s
    'There was a problem generating the robot name'
  end
end

class Robot
  attr_accessor :name
  @@registry

  def initialize(args = {})
    @@registry ||= []
    # binding.pry
    @name_generator = args[:name_generator]
    need_name?
    @@registry.push(check_name(name))
  end

  def need_name?
    if @name_generator
      @name = @name_generator.call
    else
      create_name
    end
  end

  def create_name
    @name = []
    generate_char = -> { ('A'..'Z').to_a.sample }
    generate_num = -> { rand(10) }
    2.times { @name << generate_char.call }
    3.times { @name << generate_num.call }
    @name = @name.join('')
  end

  def check_name(name)
    raise NameCollisionError if @@registry.include?(name)
    raise NameCollisionError unless name =~ /[[:alpha:]]{2}[[:digit:]]{3}/
    name
  end
end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
generator = -> { 'AB312' }
robot = Robot.new(name_generator: generator)
puts "Robot's name is #{robot.name}, but we usually call him Sparky"
# Robot.new(name_generator: generator)
