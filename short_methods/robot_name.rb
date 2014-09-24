class NameCollisionError < RuntimeError; end;

class Robot
  attr_accessor :name

  @@registry

  def initialize(args = {})
   @@registry ||= []
   @name_generator = args[:name_generator]
   @name = pending_name
   check_errors
   @@registry << @name
  end



  def pending_name   
   @name = @name_generator ?  @name_generator.call : name_output  
  end

  def name_output
    "#{gen_char}#{gen_num}"
  end

  def gen_char    
      ('A'..'Z').to_a.sample(2).join    
  end

  def gen_num    
    ('0'..'9').to_a.sample(3).join     
  end

  def check_errors  
   raise_error if name_match || @@registry.include?(name)
  end

  def raise_error
    raise NameCollisionError, 'There was a problem generating the robot name!' 
  end

  def name_match
    !(name =~ /^\w{2}\d{3}$/)
  end
end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

generator = -> { 'AA111' }
robot = Robot.new(name_generator: generator)
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."
generator = -> { 'AB007' }
robot = Robot.new(name_generator: generator)
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."
