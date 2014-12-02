class NameCollisionError < RuntimeError; end

class Robot
  attr_accessor :name

  @@registry = ["DT447"]

  def initialize(args = {})

    @@registry ||= []

    @name = args[:name_generator]

    begin
      raise NameCollisionError if invalid_name?(@name)
    rescue
      @name = create_name
    end

    @@registry << @name
  end

  private

  def invalid_name?(name)
    invalid_format?(name) || registry_duplicate?(name)
  end

  def invalid_format?(name)
    !(name =~ /[[:alpha:]]{2}[[:digit:]]{3}/)
  end

  def registry_duplicate?(name)
    @@registry.include?(name)
  end

  def create_name
    generate_char = -> { ('A'..'Z').to_a.sample }
    generate_num = -> { rand(10) }

    "#{generate_char.call}#{generate_char.call}#{generate_num.call}#{generate_num.call}#{generate_num.call}"
  end
end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

robot3 = Robot.new
puts "My pet robot's name is #{robot3.name}, but we usually call him sparky."

robot2 = Robot.new(name_generator: "DT447")
puts "My pet robot's name is #{robot2.name}, but we usually call him sparky."

# Errors!
# generator = -> { 'AA111' }
# Robot.new(name_generator: generator)
# Robot.new(name_generator: generator)
