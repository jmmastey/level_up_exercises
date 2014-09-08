class NameCollisionError < RuntimeError; end;

class Robot
  MAX_NAMING_ATTEMPTS = 3

  attr_accessor :name

  #@@registry

  def initialize(args = {})
    @@registry ||= []
    create_name(args[:name_generator])
  end

  private

  def create_name(name_generator)
    name_generator ||= lambda(&method(:default_name_generator))

    @name = name_generator.call
    check_name_validity

    @@registry << @name
  end

  def check_name_validity
    if !(name =~ /[[:alpha:]]{2}[[:digit:]]{3}/) || @@registry.include?(name)
      raise NameCollissionError, "There was a problem generating the robot name!"
    end
  end

  def default_name_generator
    generate_char = -> { ('A'..'Z').to_a.sample }
    generate_num = -> { rand(10) }

    "#{generate_char.call}#{generate_char.call}#{generate_num.call}" <<
    "#{generate_num.call}#{generate_num.call}"
  end
end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
# generator = -> { 'AA111' }
# Robot.new(name_generator: generator)
# Robot.new(name_generator: generator)
