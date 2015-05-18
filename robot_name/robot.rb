class Robot
  attr_accessor :name

  def initialize(name)
    @name = name
    puts "I'm your new robot named #{name}, but you can call me Sparkles!"
  end
end
