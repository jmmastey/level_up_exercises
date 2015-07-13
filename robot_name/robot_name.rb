class NameCollisionError < RuntimeError; end

class Robot
  attr_accessor :name

  def initialize(args = {})
    @registry ||= []
    @name_generator = args[:name_generator]

    @name_generator ? @name = @name_generator.call : generate_name
    check_name
  end

  def generate_name
    generate_char = -> { ('A'..'Z').to_a.sample }
    generate_num = -> { rand(10) }
    @name = "#{generate_char.call}#{generate_char.call}"
    @name << "#{generate_num.call}#{generate_num.call}#{generate_num.call}"
  end

  def check_name
    if !(name =~ /[[:alpha:]]{2}[[:digit:]]{3}/) || @registry.include?(name)
      raise NameCollisionError, 'There was a problem generating the robot name!'
    end
    @registry << @name
  end
end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
# generator = -> { 'AA111' }
# Robot.new(name_generator: generator)
# Robot.new(name_generator: generator)
