require_relative "arrowhead"

class ArrowheadCollection
  attr_accessor :arrowheads

  def initialize
    @arrowheads = []
  end

  def add(args)
    arrowheads << Arrowhead.new(args)
  end
end
