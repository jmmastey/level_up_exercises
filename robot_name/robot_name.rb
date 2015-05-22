class NameCollisionError < RuntimeError; end

class Robot
  attr_accessor :name
  def initialize(args = {})
    @@registry ||= []
    name_generator = args[:name_generator]
    if name_generator
      self.name = name_generator.call
    else
      self.name = generate_name
    end
  end

  def generate_name
    generate_char = -> { ('A'..'Z').to_a.sample }
    generate_num = -> { rand(10) }
    name = "#{generate_char.call}#{generate_char.call}#{generate_num.call}"
    name << "#{generate_num.call}#{generate_num.call}"
    # puts name
    raise_collistion_error unless valid?(name)

    @@registry << name
    name
  end

  def valid?(name)
    name =~ /[[:alpha:]]{2}[[:digit:]]{3}/ && !@@registry.include?(name)
  end

  def raise_collistion_error
    raise NameCollisionError, 'There was a problem generating the robot name!'
  end
end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him Artoo."

# Errors!
# generator = -> { 'AA111' }
# Robot.new(name_generator: generator)
# Robot.new(name_generator: generator)
