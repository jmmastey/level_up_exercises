class NameCollisionError < RuntimeError; end;

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
      set_name(generate_default_name)
    else
      set_name(@name_generator.call.to_s)
    end
  end

  def get_name_registry
    @@registry
  end

  private

  def set_name(name)
    unless name_valid?(name)
      raise NameCollisionError, 'There was a problem generating the robot name!'
    end

    @name = name
    @@registry << name
  end

  def generate_default_name
    generate_num = -> { rand(10).to_s }
    generate_char = -> { ('A'..'Z').to_a.sample }
    name = ''

    2.times.map { name << generate_char.call }
    3.times.map { name << generate_num.call }

    name
  end

  def name_valid?(name)
    (name =~ /[[:alpha:]]{2}[[:digit:]]{3}/) || @@registry.include?(name)
  end
end
