class NameCollisionError < RuntimeError; end

class Robot
  attr_accessor :name

  @@registry

  def initialize
    @@registry ||= []
    @name = generate_name
    if !(name =~ /[[:alpha:]]{2}[[:digit:]]{3}/) || @@registry.include?(name)
      raise NameCollisionError, 'There was a problem generating the robot name!'
    end
    @@registry << @name
  end

  def generate_name
    generated_name = ''
    (0..1).each { generated_name += ('A'..'Z').to_a.sample }
    (0..2).each { generated_name += rand(10).to_s }
    generated_name
  end
end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
# generator = -> { 'AA111' }
# Robot.new(name_generator: generator)
# Robot.new(name_generator: generator)
