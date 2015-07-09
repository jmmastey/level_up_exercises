class NameCollisionError < RuntimeError; end

class Robot
  attr_accessor :name
  attr_accessor :name_generator

  @@registry = []

  def initialize(args = {})
    @name_generator = args[:name_generator]
    @name = generate_name

    check_name_collision
    @@registry << name
  end

  def generate_name
    if name_generator
      name_generator.call
    else
      generate_character_sequence(2) + generate_number_sequence(3)
    end
  end

  def generate_character_sequence(count)
    sequence = ""
    count.times { sequence << generate_character }
    sequence
  end

  def generate_number_sequence(count)
    sequence = ""
    count.times { sequence << generate_number }
    sequence
  end

  def generate_character
    ('A'..'Z').to_a.sample
  end

  def generate_number
    rand(10).to_s
  end

  def check_name_collision
    return if name =~ /[[:alpha]]{2}[[:digit:]]{3}/
    return unless @@registry.include?(name)

    raise NameCollisionError, 'There was a problem generating the robot name!'
  end
end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
# generator = -> { 'AA111' }
# Robot.new(name_generator: generator)
# Robot.new(name_generator: generator)
