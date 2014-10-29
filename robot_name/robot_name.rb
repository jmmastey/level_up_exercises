require_relative 'name_collision_error'
require_relative 'pattern_error'

class Robot
  attr_reader :name

  NAME_LENGTH = 5
  NAME_CHAR_LENGTH = 2
  NAME_NUM_LENGTH = 3

  class << self
    attr_accessor :registry
  end

  def initialize(args = {})
    self.class.registry ||= []
    @name_generator = args[:name_generator] || method(:default_name_generator)
    assign_name
  end

  def assign_name
    new_name = @name_generator.call
    check_name_collision(new_name)
    check_pattern(new_name)
    self.class.registry << (@name = new_name)
  end

  def generate_name
    NAME_LENGTH.times.to_a.each_with_object('') do |i, new_name|
      range = i < NAME_CHAR_LENGTH ? ('A'..'Z') : ('0'..'9')
      new_name << range.to_a.sample
    end
  end

  def check_name_collision(name)
    raise NameCollisionError if self.class.registry.include? name
  end

  def check_pattern(name)
    pattern = "^[A-Z]{#{NAME_CHAR_LENGTH}}[0-9]{#{NAME_NUM_LENGTH}}$"
    raise PatternError unless name =~ Regexp.new(pattern)
  end

  def default_name_generator
    loop do
      new_name = generate_name
      return new_name unless self.class.registry.include? new_name
    end
  end

  private :assign_name, :generate_name, :check_name_collision, :check_pattern,
    :default_name_generator
end
