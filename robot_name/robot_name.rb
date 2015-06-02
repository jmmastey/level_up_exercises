class NameCollisionError < RuntimeError; end

class NameFormatError < RuntimeError; end

class Robot
  attr_accessor :name

  @@registry

  def initialize(args = {})
    @@registry ||= []
    @name_generator = args[:name_generator] || lambda { name_generator }
    @name = @name_generator.call
    raise NameFormatError, 'Could not create Robot' unless valid_name?(name)
    @@registry << @name
  end

  def valid_name?(name)
    valid_format?(name) && !in_use?(name)
  end

  def valid_format?(name)
    (name =~ /[[:alpha:]]{2}[[:digit:]]{3}/) 
  end

  def in_use?(name)
    @@registry.include?(name)
  end
  

  def char_generator
    -> { ('A'..'Z').to_a.sample }
  end

  def num_generator
    -> { rand(10) }
  end

  def name_generator
    name = ""
    2.times do 
      name += char_generator.call
    end
    3.times do
      name += num_generator.call.to_s
    end   
    name    
  end 

end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
generator = -> { 'AA111' }
# Robot.new(name_generator: generator)
#Robot.new(name_generator: generator)
Robot.new(name_generator: generator)
#Robot.new(name_generator: generator)


erator: generator)


