require './name_collision_error.rb'
class Registry
  attr_accessor :names

  def initialize
    @names = []
  end

  def check_duplicate(name)
    raise NameCollisionError, "#{name} is a duplicate." if @names.include?(name)
  end
end
