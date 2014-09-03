class NameCollisionError < RuntimeError; end;

class Robot
  attr_accessor :name

  def initialize(args = nil)
    @@registry ||= []
    generate_name(args)
  end

  def generate_name(params)
    params == nil ? @name = name_generator : @name = params
    @@registry << @name if ! @@registry.include? @name
  end

  private

  def name_generator
    generate_char = -> { ("A".."Z").to_a.sample }
    generate_num = -> { rand(10) }

    @name = "#{generate_char.call}#{generate_char.call}#{generate_num.call}
      #{generate_num.call}#{generate_num.call}"
  
    raise NameCollisionError, 'There was a problem generating the robot name!' if 
      !(@name =~ /[[:alpha:]]{2}[[:digit:]]{3}/) || @@registry.include?(name)
  end
end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
# generator = -> { 'AA111' }
# Robot.new(name_generator: generator)
# Robot.new(name_generator: generator)
