class NameCollisionError < RuntimeError; end

class DefaultNameGenerator
  def call
    generate_char = -> { ('A'..'Z').to_a.sample }
    generate_num = -> { rand(10) }

    # pattern AB123
    "#{generate_char.call}#{generate_char.call}"\
    "#{generate_num.call}#{generate_num.call}#{generate_num.call}"
  end
end

class Registry
  attr_reader :registry

  def initialize(_args = {})
    @registry = []
  end

  def add_entry(new_entry)
    validate_entry(new_entry)
    @registry.push(new_entry)
  end

  def validate_entry(new_entry)
    # garbage sorting
    if new_entry == '' || new_entry.nil?
      raise "GarbageError"
    # pattern matching
    elsif !(new_entry =~ /[[:alpha:]]{2}[[:digit:]]{3}/)
      raise "PatternMatchingError"
    # redundancy matching
    elsif @registry.include?(new_entry)
      raise NameCollisionError
    end
  end
end

class Robot
  attr_accessor :name

  def initialize(args = {})
    @name_generator = assign_name_generator(args[:name_generator])
    @registry = args[:registry]
    @max_attempts = 10

    produce_valid_name
  end

  def assign_name_generator(name_generator)
    name_generator.nil? ? DefaultNameGenerator.new : name_generator
  end

  def generate_self_name
    @name = @name_generator.call
  end

  def produce_valid_name
    begin
      generate_self_name
      @registry.add_entry(@name)
    rescue NameCollisionError
      max_attempts -= 1
      retry unless @max_attempts == 0
    rescue StandardError => error
      puts "Error: " << error.to_s
    end
  end
end

registry = Registry.new
robot = Robot.new(registry: registry)
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
# generator = -> { 'AA111' }
# Robot.new(name_generator: generator)
# Robot.new(name_generator: generator)
