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
    @name_generator = args[:name_generator] || default_name_generator
    generate_name
  end

  def generate_name
    name = @name_generator.call

    check_name_collision(name)
    check_pattern(name)

    self.class.registry << (@name = name)
  end

  def check_name_collision(name)
    raise NameCollisionError if self.class.registry.include? name
  end

  def check_pattern(name)
    pattern = "^[A-Z]{#{NAME_CHAR_LENGTH}}[0-9]{#{NAME_NUM_LENGTH}}$"
    raise PatternError unless name =~ Regexp.new(pattern)
  end

  def default_name_generator
    lambda do
      NAME_LENGTH.times.to_a.each_with_object('') do |i, name|
        range = i < NAME_CHAR_LENGTH ? ('A'..'Z') : ('0'..'9')
        name << range.to_a.sample
      end
    end
  end

  private :generate_name, :check_name_collision, :check_pattern,
    :default_name_generator
end
