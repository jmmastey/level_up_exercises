class NameCollisionError < RuntimeError; end;

class Robot
  attr_accessor :name
  @@registry

  def initialize(args = {})
    @@registry ||= []
    @name_generator = args[:name_generator]
    generate_name
  end

  private

  def generate_name

    generated_name = ""
    #generate_num = -> { rand(10) }
    #generate_char = -> { ('A'..'Z').to_a.sample }

    2.times.collect { generated_name << generate_char }
    3.times.collect { generated_name << generate_num.to_s }

    if is_name_valid?(generated_name)
      raise NameCollisionError, 'There was a problem generating the robot name'
    else
      set_name(generated_name)
    end
  end

  def set_name(name)
    @name = name
    @@registry << name
  end

  def generate_num
    rand(10)
  end

  def generate_char
    ('A'..'Z').to_a.sample
  end

  def is_name_valid?(name)
    !(name =~ /[[:alpha:]]{2}[[:digit:]]{3}/) || @@registry.include?(name)
  end
end

# Errors!
generator = -> { 'AA111' }
robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."


=begin

This is the OLD WAY... Need to do this thing

class NameCollisionError < RuntimeError; end;

class Robot
  attr_accessor :name

  @@registry

  def initialize(args = {})
    @@registry ||= []
    @name_generator = args[:name_generator]


    if @name_generator
      @name = @name_generator.call
    else
      generate_char = -> { ('A'..'Z').to_a.sample }
      generate_num = -> { rand(10) }

      @name = "#{generate_char.call}#{generate_char.call}#{generate_num.call}#{generate_num.call}#{generate_num.call}"
    end

    raise NameCollisionError, 'There was a problem generating the robot name!' if !(name =~ /[[:alpha:]]{2}[[:digit:]]{3}/) || @@registry.include?(name)
    @@registry << @name
  end

end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
# generator = -> { 'AA111' }
# Robot.new(name_generator: generator)
# Robot.new(name_generator: generator)
=end

