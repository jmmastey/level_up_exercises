require 'set'

class NameCollisionError < RuntimeError
  def message
    "That Name already exists"
  end
end

class IllegalCharactersError < RuntimeError
  def message
    "Illegal Characters were found"
  end
end

class Robot
  attr_accessor :name

  def initialize(args = {})
    @@register ||= Set.new
    @name_gen = args[:name_generator]

    r_name = ('A'..'Z').to_a.sample(2).join("") + (0..9).to_a.sample(3).join("")

    @name_gen.nil? ? create_name { r_name } : create_name { @name_gen.call }
  end

  def create_name
    @name = yield
    validates_name
  end

  def validates_name
    raise IllegalCharactersError unless @name =~ /[[:alpha:]]{2}[[:digit:]]{3}/
    raise NameCollisionError if @@register.include?(@name)
    @@register << @name
  end

  def to_s
    "My pet robot's name is #{name}, but we usually call him sparky"
  end

  def self.display_name
    @@register.to_a.each do | name |
       puts "My pet robot's name is #{name}, but we usually call him sparky"
    end
  end
end

puts Robot.new
puts Robot.new
generator = -> { 'AA111' }
puts Robot.new(name_generator: generator)
puts Robot.new(name_generator: generator)
