class NameCollisionError < RuntimeError; end

class Robot
  attr_accessor :name

  NAME_ERROR_MSG = "There was a problem generating the robot name!"

  @@registry

  def initialize(args = {})
    @@registry ||= []
    @name_generator = args[:name_generator]
    @name = pick_a_name

    raise NameCollisionError, NAME_ERROR_MSG if name_issues?(@name)

    @@registry << @name
  end

  def pick_a_name
    if @name_generator
      @name_generator.call
    else
      generate_name
    end
  end

  def generate_name
    "#{generate_two_letters}#{generate_three_numbers}"
  end

  def generate_two_letters
    generate_char = -> { ('A'..'Z').to_a.sample }
    "#{generate_char.call}#{generate_char.call}"
  end

  def generate_three_numbers
    generate_num = -> { rand(10) }
    "#{generate_num.call}#{generate_num.call}#{generate_num.call}"
  end

  def name_issues?(name)
    !standard_name_format?(name) || name_already_exists?(name)
  end

  def standard_name_format?(name)
    name =~ /[[:alpha:]]{2}[[:digit:]]{3}/
  end

  def name_already_exists?(name)
    @@registry.include?(name)
  end
end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
# generator = -> { 'AA111' }
# Robot.new(name_generator: generator)
# Robot.new(name_generator: generator)
