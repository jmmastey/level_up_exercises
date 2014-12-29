class NameCollisionError < RuntimeError; end

class Robot
  attr_accessor :name

  @@registry ||= []

  def initialize(args = {})
    if args[:name_generator]
      @name = args[:name_generator].call while name_is_unacceptable?(@name)
    else
      @name = generate_name while name_is_unacceptable?(@name)
    end
    
    @@registry << @name
  end
  
  
private
  
# TODO: 
  def generate_name
    generate_chars =-> { ('A'..'Z').to_a.sample(2).join('') }
    generate_nums  =-> { sprintf("%03d", rand(000..999)) }
    
    name = "#{generate_chars.call}#{generate_nums.call}"
  end
  
  def name_exists_in_registry?(name)
    @@registry.include?(name)
  end
  
  def name_is_badly_formed?(name)
    !(name =~ /[[:alpha:]]{2}[[:digit:]]{3}/)
  end
  
  def name_is_unacceptable?(name = '')
    name_is_badly_formed?(name) || name_exists_in_registry?(name)
  end
end


robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
# generator = -> { 'AA111' }
# Robot.new(name_generator: generator)
# Robot.new(name_generator: generator)
