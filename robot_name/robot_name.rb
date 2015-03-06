class NameCollisionError < RuntimeError; end

class Robot
  attr_accessor :name

  @@registry

  def initialize(args = {})
    @@registry ||= []
    @name_generator = args[:name_generator]

    generate_name

    if !(name =~ /[[:alpha:]]{2}[[:digit:]]{3}/) || @@registry.include?(name)
      raise NameCollisionError, 'There was a problem generating the robot name!' 
    end

    @@registry << @name
  end

  def generate_name
    if @name_generator
      @name = @name_generator.call
    else
      generate_char = -> { ('A'..'Z').to_a.sample }
      generate_num = -> { rand(10) }

      @name = manually_generate_name(generate_char, generate_num)
    end
  end

  def manually_generate_name(chars, nums)
    "#{chars.call}"\
      "#{chars.call}"\
      "#{nums.call}"\
      "#{nums.call}"\
      "#{nums.call}"
  end
end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
# generator = -> { 'AA111' }
# Robot.new(name_generator: generator)
# Robot.new(name_generator: generator)
