class Robot
  attr_accessor :name

  @@registry ||= []

  def initialize(args = {})
    @name = create_name(args)
    validate_name(@name)
    @@registry << @name
  end

  private

  def validate_name(name)
    validate_pattern(name)
    check_for_duplicate(name)
  end

  def check_for_duplicate(name)
    message = "name '#{name}' is a duplicate of a previously created name"
    raise ArgumentError, message if @@registry.include?(name)
  end

  def validate_pattern(name)
    message = "name '#{name}' doesn't fit the pattern"
    raise ArgumentError, message unless name =~ /[[:alpha:]]{2}[[:digit:]]{3}/
  end

  def create_name(args)
    if args[:name_generator]
      args[:name_generator].call
    else
      "#{generate_chars(2)}#{generate_numbers(3)}"
    end
  end

  def generate_numbers(length)
    sprintf("%0#{length}d", rand(10**length))
  end

  def generate_chars(length)
    ('A'..'Z').to_a.sample(length).join
  end
end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

generator = -> { "AB123" }
robot = Robot.new(:name_generator => generator)
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

begin
  robot = Robot.new(:name_generator => generator)
  puts "My pet robot's name is #{robot.name}, but we usually call him sparky."
rescue ArgumentError => error
  puts error.message
end

generator = -> { "your mom" }
begin
  robot = Robot.new(:name_generator => generator)
  puts "My pet robot's name is #{robot.name}, but we usually call him sparky."
rescue ArgumentError => error
  puts error.message
end
