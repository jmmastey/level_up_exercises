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

    raise ArgumentError, 'There was a problem generating the robot name!' if !(name =~ /[[:alpha:]]{2}[[:digit:]]{3}/) || @@registry.include?(name)
    @@registry << @name
  end

end


robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."
generator = lambda { "AB123" }
robot = Robot.new(:name_generator => generator)
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."
generator = lambda { "your mom" }
begin
  robot = Robot.new(:name_generator => generator)
  puts "My pet robot's name is #{robot.name}, but we usually call him sparky."
rescue ArgumentError => error
  puts error.message
end


# Errors!
# generator = -> { 'AA111' }
# Robot.new(name_generator: generator)
# Robot.new(name_generator: generator)
