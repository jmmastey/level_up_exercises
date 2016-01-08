class NameCollisionError < RuntimeError; end

class Robot
  attr_accessor :name

  @@registry

  def initialize(args = {})
    @@registry ||= []
    @name_generator = args[:name_generator]

    if @name_generator
      @name = @name_generator.call
    else
      @name = "#{generate_char(2)}#{generate_num(3)}"
    end

    if !(name =~ /[[:alpha:]]{2}[[:digit:]]{3}/) || @@registry.include?(name)
      raise NameCollisionError, "There was a problem generating the robot name #{@name}!"
    end

    @@registry << @name
  end

  def generate_char(total_char)
    ('A'..'Z').to_a.sample(total_char).join
  end

  def generate_num(total_num)
    nums = []
    (1..total_num).each do |n|
      nums << rand(10)
    end
    nums.join
  end
end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
# generator = -> { 'AA111' }
# Robot.new(name_generator: generator)
# Robot.new(name_generator: generator)
