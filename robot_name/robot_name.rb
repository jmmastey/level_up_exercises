class NameCollisionError < RuntimeError; end

class Robot
  attr_accessor :name

  @@registry

  def initialize(args = {})
    @@registry ||= []
    @name_generator = args[:name_generator] # this will be nil is called without an argument

    assign_name

    raise NameCollisionError, 'There was a problem generating the robot name!' if !(name =~ /[[:alpha:]]{2}[[:digit:]]{3}/) || @@registry.include?(name)
    @@registry << @name
  end

  def assign_name
    if @name_generator
      @name = @name_generator.call
    else
      generate_new_name
    end
  end

  def generate_new_name
    generate_char = -> { ('A'..'Z').to_a.sample }
    generate_num = -> { rand(10) }
    @name = "#{generate_char.call}#{generate_char.call}#{generate_num.call}#{generate_num.call}#{generate_num.call}"
  end

  # New method: add name to registry
end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
# generator = -> { 'AA111' }
# Robot.new(name_generator: generator)
# Robot.new(name_generator: generator)
