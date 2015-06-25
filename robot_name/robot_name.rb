class NameCollisionError < RuntimeError
  def message
    'There was a problem generating the robot name!'
  end
end

class NameFormatError < RuntimeError
  def message
    'The robot name was not in the correct format.'
  end
end

class Robot
  attr_accessor :name

  @@registry

  def name_generator(args)
    @name_generator = args[:name_generator]
    @name = @name_generator.call if @name_generator
  end

  def random_name_generator
    generate_char = -> { ('A'..'Z').to_a.sample }
    generate_num = -> { rand(10) }

    alpha = "#{generate_char.call}#{generate_char.call}"
    numeric = "#{generate_num.call}#{generate_num.call}#{generate_num.call}"
    @name = alpha + numeric
  end

  def validate_generated_name
    raise NameCollisionError if @@registry.include?(name)
    raise NameFormatError if !(name =~ /[[:alpha:]]{2}[[:digit:]]{3}/)
  end

  def error_output(e)
    puts "#{e.message} (#{e})"
  end

  def initialize(args = {})
    @@registry ||= []

    name_generator(args)
    random_name_generator unless @name_generator

    begin
      validate_generated_name
    rescue StandardError => e
      error_output(e)
    end

    @@registry << @name
  end
end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
generator = -> { 'CHAPPIE' }
Robot.new(name_generator: generator)

generator = -> { 'AA111' }
Robot.new(name_generator: generator)
Robot.new(name_generator: generator)
