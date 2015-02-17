class NameCollisionError < RuntimeError; end
class InvalidFormatError < RuntimeError; end

# Generates name for Robot
class NameGenerator
  attr_accessor :name
  @@registry = []

  def self.name(args)
    @name = args[:k]
    if @name
      fail InvalidFormatError, 'Not supported format' unless pattern?
    else
      generate_name
    end
    repeated?
  end

  def self.random_num
    rand(10)
  end

  def self.random_char
    ('A'..'Z').to_a.sample
  end

  def self.generate_name
    str_arr = []
    (1..5).each do |i|
      str_arr << (i == 1 || i == 2 ? random_char : random_num.to_s)
    end
    @name = str_arr.join
  end

  def self.pattern?
    @name =~ /[[:alpha:]]{2}[[:digit:]]{3}/
  end

  def self.repeated?
    if @@registry.include?(@name)
      fail NameCollisionError, 'There was a problem generating the robot name!'
    end
    @@registry << @name
    @name
  end
end
