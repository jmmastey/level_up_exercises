class Catalog
  attr_accessor :name

  @dinosaurs ||= []

  class << self
    attr_accessor :dinosaurs
  end

  def initialize(name)
    @name = name
    @dinosaurs = []
  end
end
