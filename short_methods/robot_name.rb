NameCollisionError = Class.new(RuntimeError)

class Robot
  attr_accessor :name

  @@registry

  def initialize(args = {})
    @@registry ||= []
    @name_generator = args[:name_generator]

		assign_name
		
		register_name
  end

	def assign_name
    if name_generator
      @name = name_generator.call
    else
			generate_name
    end
	end

	def register_name
		if !(name =~ /[[:alpha:]]{2}[[:digit:]]{3}/) or @@registry.include?(name)
	    raise NameCollisionError, 'There was a problem generating the robot name!' 
		end

    @@registry << @name
	end
	
	def generate_name
  	generate_char = -> { ('A'..'Z').to_a.sample }
    @name = "#{generate_char.call}#{generate_char.call}#{rand(111...999)}"
	end

end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
# generator = -> { 'AA111' }
# Robot.new(name_generator: generator)
# Robot.new(name_generator: generator)
