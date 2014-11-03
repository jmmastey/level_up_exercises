class NameCollisionError < RuntimeError; end
class IllegalCharactersError < RuntimeError; end

class Robot
  attr_accessor :name

  def initialize(args = {})
    @@registry ||= []
    @name_generator = args[:name_generator]
    creates_name
  end

  def creates_name
    if @name_generator
      create_name_using_name_generator
    else
      create_name_using_gen_caller
    end
  end

  def create_name_using_name_generator
    @name = @name_generator.call
    validates_name
  end

  def create_name_using_gen_caller
    gen_char = -> { ('A'..'Z').to_a.sample }
    gen_num = -> { rand(10) }
    char = "#{gen_char.call}#{gen_char.call}"
    num = "#{gen_num.call}#{gen_num.call}#{gen_num.call}"
    @name = char + num
    validates_name
  end

  def validates_name
    raise IllegalCharactersError unless @name =~ /[[:alpha:]]{2}[[:digit:]]{3}/
    raise NameCollisionError if @@registry.include?(@name)
    @@registry << @name
  end

  def to_s
    "My pet robot's name is #{name}, but we usually call him sparky"
  end
end

robot1 = Robot.new
robot2 = Robot.new

puts robot1
puts robot2

#
# Errors!
generator = -> { 'AA111' }
puts Robot.new(name_generator: generator)

#puts Robot.new(name_generator: generator)
