class NameCollisionError < RuntimeError; end

class Robot
  attr_accessor :name

  def initialize(args = {})
    @@registry ||= []
    @name_generator = args[:name_generator]
    generate_name
  end

  def generate_name
    if @name_generator.nil?
      add_name_to_registry(generate_random_name)
    else
      add_name_to_registry(@name_generator.call.to_s)
    end
  end

  def name_registry
    @@registry
  end

  private

  def add_name_to_registry(name)
    unless name_valid?(name)
      raise NameCollisionError, 'There was a problem generating the robot name!'
    end
    @name = name
    @@registry << name
  end

  def generate_random_name
    "#{generate_char(2)}#{generate_num(3)}"
  end

  def generate_num(n)
    n.times.map { rand(10) }.join
  end

  def generate_char(n)
    n.times.map { ('A'..'Z').to_a.sample }.join
  end

  def name_valid?(name)
    (name =~ /[[:alpha:]]{2}[[:digit:]]{3}/) && !@@registry.include?(name)
  end
end
