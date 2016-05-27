class Robot
  attr_accessor :name

  @@registry

  def initialize(args = {})
    @@registry ||= []
    @name_generator = args[:name_generator]

    if @name_generator
      @name = @name_generator.call
    else
      name_constructor
    end
    add_name
  end

  def add_name
    @@registry << @name
    p @@registry
  end

  def name_constructor
    generate_char = ('A'..'Z').to_a.sample(2)
    generate_num = (1..10).to_a.sample(3)
    @name = generate_char.concat(generate_num).join
  end

  def duplicate_name?
    if !(name =~ /[[:alpha:]]{2}[[:digit:]]{3}/) || @@registry.include?(name)
      raise NameCollisionError, 'There was a problem generating the robot name!'
    end
  end
end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
# generator = -> { 'AA111' }
# Robot.new(name_generator: generator)
# Robot.new(name_generator: generator)
