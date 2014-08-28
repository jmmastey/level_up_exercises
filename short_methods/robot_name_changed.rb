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
      generate_name
    end

    @@registry << @name
    puts @@registry.inspect
    raise NameCollisionError, 'There was a problem generating the robot name! The names are repetitive!' if check_generated_name?(name)
  end


  def generate_name
    generate_char = -> { ('A'..'Z').to_a.sample }
    generate_num = -> { rand(10) }

    @name = "#{generate_char.call}#{generate_char.call}#{generate_num.call}#{generate_num.call}#{generate_num.call}"
    @name

  end

  def check_generated_name?(name)
    !(generate_name =~ /[[:alpha:]]{2}[[:digit:]]{3}/) || @@registry.include?(name)
  end


end

#This should result in name space collision error
generator = -> { 'AA111' }
robot1 = Robot.new(name_generator: generator)
puts "My pet robot's name is #{robot1.name}, but we usually call him sparky."
robot2 =  Robot.new(name_generator: generator)
puts "My pet robot's name is #{robot2.name}, but we usually call him sparky."
robot3 = Robot.new(name_generator: generator)
puts "My pet robot's name is #{robot3.name}, but we usually call him sparky."
