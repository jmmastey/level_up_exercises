class NameCollisionError < RuntimeError; end
class NameFormatError < RuntimeError; end

class Robot
  attr_accessor :name

  @@registry

  def initialize(args = {})
    @@registry ||= []
    @name_generator = args[:name_generator] || make_generator
    @name = @name_generator.call
    raise NameFormatError, 'Incorrect format for robot name' unless valid_format?(name?)  
    raise NameCollisionError, 'Robot name already in use' if in_use?(name)
    @@registry << @name
  end

  def valid_format?(name)
    (name =~ /[[:alpha:]]{2}[[:digit:]]{3}/) 
  end

  def in_use?(name?)
    @@registry.include?(name)
  end
  
  def make_generator
    generate_char = -> { ('A'..'Z').to_a.sample }
    generate_num = -> { rand(10) }
    return -> { "#{generate_char.call}#{generate_char.call}#{generate_num.call}#{generate_num.call}#{generate_num.call}" }
  end 


end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
generator = -> { 'AA111' }
Robot.new(name_generator: generator)
Robot.new(name_generator: generator)





ame_generator: generator)











