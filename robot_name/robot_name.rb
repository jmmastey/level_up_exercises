class NameCollisionError < RuntimeError; end

class Robot
  attr_accessor :name

  @@registry  # Scope of this variable is limited to this class but not to the specific instance of the class

  def initialize(args = {})
    @@registry ||= [] #Assigns @@registry to [] only if it is nil
    puts 'name_generator is', @name_generator
    puts 'key is', args.keys
    @name_generator = args[:name_generator]

    if @name_generator
      @name = @name_generator.call
    else
      #Creates a generator for characters
      generate_char = -> { ('A'..'Z').to_a.sample }
      #Creates a generator of integers between 0 and 9
      generate_num = -> { rand(10) }
      @name = "#{generate_char.call}#{generate_char.call}#{generate_num.call}#{generate_num.call}#{generate_num.call}"
    end
 
    # Check if name is exact match to regex or if name already used
    if name[/^[[:alpha:]]{2}[[:digit:]]{3}$/].nil? || @@registry.include?(name) 
      puts @name.class
      raise NameCollisionError, 'There was a problem generating the robot name!'
    else
      @@registry << @name
    end

  end
end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
# generator = -> { 'AA111' }
# Robot.new(name_generator: generator)
# Robot.new(name_generator: generator)
