class NameCollisionError < RuntimeError; end

class Robot
  attr_accessor :name, :generated_name

  def initialize(args = {})
    @@registry ||= []
    @generated_name = ''
    @name_generator = args[:name_generator]
    generate_name
  end

  def generate_name
    if @name_generator.nil?
      add_name_to_registry(generate_default_name)
    else
      add_name_to_registry(@name_generator.call.to_s)
    end
  end

  def add_name_to_registry(name)
    unless name_valid?(name)
      raise NameCollisionError, 'There was a problem generating the robot name!'
    end
    @name = name
    @@registry << name
  end

  def get_name_registry
    @@registry
  end

  private

  def generate_default_name
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
