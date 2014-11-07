require_relative 'error_name_collision.rb'
require_relative 'registry.rb'

class Robot
  attr_accessor :name

  def initialize(args = {})
    @name_generator = args[:name_generator]
    @name           = @name_generator ? @name_generator.call : name_generator

    raise NameCollisionError if name_collision? @name
    Registry.add @name
  end

  def shuffle
    @name = @name.split('').shuffle.join('')
  end

  def pretty
    "My pet robot's name is #{@name}, but we usually call him sparky."
  end

  private

  def name_generator
    name = ''
    name << adder(name) while invalid_name?(name)
    name
  end

  def name_collision?(name)
    invalid_name?(name) || duplicate?(name)
  end

  def duplicate?(name)
    Registry.names.include? name
  end

  def invalid_name?(name)
    invalid_num_count?(name) || invalid_char_count?(name)
  end

  def invalid_num_count?(str)
    !(str =~ /[[:digit:]]{3}/)
  end

  def invalid_char_count?(str)
    !(str =~ /[[:alpha:]]{2}/)
  end

  def random_alphanum
    (random_char + random_num.to_s).split('').sample
  end

  def random_char
    ('A'..'Z').to_a.sample
  end

  def random_num
    rand(10)
  end

  def adder(str)
    if invalid_char_count?(str)
      return random_char
    elsif invalid_num_count?(str)
      return random_num.to_s
    end
  end
end
