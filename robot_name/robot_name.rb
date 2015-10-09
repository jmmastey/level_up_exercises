class NameCollisionError < RuntimeError; end

class Robot
  attr_accessor :name

  def new_name_using_default_generator
    generate_char = -> { ('A'..'Z').to_a.sample }
    generate_num = -> { rand(10) }

    # pattern AB123
    "#{generate_char.call}#{generate_char.call}"\
    "#{generate_num.call}#{generate_num.call}#{generate_num.call}"
  end

  def new_name_is_invalid(new_name)
    # garbage sorting
    if new_name == '' || new_name.nil?
      return true
    # pattern matching
    elsif !(new_name =~ /[[:alpha:]]{2}[[:digit:]]{3}/)
      return true
    # redundancy matching
    elsif @registry.include?(new_name)
      return true
    end
    false
  end

  def initialize(args = {})
    @registry ||= []
    @name_generator = args[:name_generator]
    @name = ''

    while new_name_is_invalid(@name)
      if @name_generator
        @name = @name_generator.call
      else
        @name = new_name_using_default_generator
      end
    end

    @registry << @name
  end
end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
# generator = -> { 'AA111' }
# Robot.new(name_generator: generator)
# Robot.new(name_generator: generator)
