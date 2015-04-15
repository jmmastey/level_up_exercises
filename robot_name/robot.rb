class NameGenerationError < RuntimeError; end

class Robot
  attr_accessor :robot_name

  @@name_registry

  def initialize(name_gen = nil)
    @@name_registry ||= []
    @name_generator = name_gen

    attempts = 0
    while attempts < 3
      if @name_generator
        @robot_name = @name_generator.call
        puts "robot name is #{@robot_name}"
      else
        @robot_name = generate_name
      end
      break if valid_name?
      attempts += 1
    end

    if valid_name?
      @@name_registry << @robot_name
    else
      find_error
    end
  end

  def generate_name
    generate_char = -> { ('A'..'Z').to_a.sample } # convert range to array
    generate_num = -> { rand(10) }
    robot_name = (1..2).collect { generate_char.call }
    robot_name += (1..3).collect { generate_num.call }
    robot_name.join
  end

  def name_already_in_list?
    @@name_registry.include?(@robot_name)
  end

  def wrong_name_format?
    @robot_name[/^[[:alpha:]]{2}[[:digit:]]{3}$/].nil?
  end

  def valid_name?
    !(name_already_in_list? || wrong_name_format?)
  end

  def find_error
    if name_already_in_list?
      raise NameGenerationError, 'Name already in list.'
    else
      raise NameGenerationError, 'Name has wrong format.'
    end
  end
end

#robot = Robot.new
#puts "My pet robot's name is #{robot.robot_name}, but we usually call him Rob."

# Errors!
#  generator = -> { 'AA111' }
#generator = -> { ('A'..'Z').to_a.sample }  # Will give incorrect format error
#Robot.new(name_generator: generator)
#Robot.new(name_generator: generator)
