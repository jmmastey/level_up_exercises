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
    raise NameFormatError unless name =~ /[[:alpha:]]{2}[[:digit:]]{3}/
  end

  def error_output(e)
    puts "#{e.message} (#{e} with #{name})"
  end

  def name_output
    puts "My pet robot's name is #{name}, but we usually call him sparky."
  end

  def generate_robot_name
    name_generator(@args)
    random_name_generator unless @name_generator
  end

  def validate_robot_name
    begin
      validate_generated_name
      name_output
    rescue StandardError => e
      error_output(e)
    end
  end

  def initialize(args = {})
    @args = args
    @@registry ||= []

    generate_robot_name
    validate_robot_name

    @@registry << @name
  end
end

Robot.new

generator = -> { 'CHAPPIE' }
Robot.new(name_generator: generator)

generator = -> { 'AA111' }
Robot.new(name_generator: generator)
Robot.new(name_generator: generator)
