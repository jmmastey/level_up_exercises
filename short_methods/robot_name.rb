class NameCollisionError < RuntimeError; end;

class Robot
  attr_accessor :name
  @@registry

  def initialize(args = {})
    @@registry ||= []
    @name_generator = args[:name_generator]
    generate_name
  end

  private

  def generate_name

    generated_name = ''
    #generate_num = -> { rand(10) }
    #generate_char = -> { ('A'..'Z').to_a.sample }

    2.times.collect { generated_name << generate_char }
    3.times.collect { generated_name << generate_num.to_s }

    if name_valid?(generated_name)
      raise NameCollisionError, 'There was a problem generating the robot name'
    else
      add_robot_name(generated_name)
    end
  end

  def add_robot_name(name)
    @name = name
    @@registry << name
  end

  def generate_num
    rand(10)
  end

  def generate_char
    ('A'..'Z').to_a.sample
  end

  def name_valid?(name)
    !(name =~ /[[:alpha:]]{2}[[:digit:]]{3}/) || @@registry.include?(name)
  end
end

# Errors!
generator = -> { 'AA111' }
robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."