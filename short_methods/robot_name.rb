class NameCollisionError < RuntimeError; end;

class Robot
  attr_accessor :name

  def initialize(args = {})
    @@registry ||= []
    @name_generator = args[:name_generator]
    args.length == 0 ? generate_name : set_name(args[:name_generator])
  end

  private

  def generate_name
    generate_char = -> { ('A'..'Z').to_a.sample }
    generate_num = -> { rand(10) }

    @name = %"#{generate_char.call}#{generate_char.call}#{generate_num
    .call}#{generate_num.call}#{generate_num.call}"

    raise NameCollisionError, 'There was a problem generating the robot name
    !' if !(@name =~ /[[:alpha:]]{2}[[:digit:]]{3}/) ||
        @@registry.include?(@name)

    @@registry << @name
  end

  def set_name(name)
    @name = name
    @@registry << name
  end
end

# Errors!
generator = -> { 'AA111' }
robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."
