require 'table_print'

class Catalog
  attr_accessor :name
  attr_accessor :dinosaurs

  def initialize(name)
    @name = name
    @dinosaurs = []
  end

  def find(keyword)
    result = @dinosaurs.find { |x| x.name == keyword }
    Display.print_one(result)
  end

  def select(category, keyword)
    results = @dinosaurs.find_all { |x| x.instance_variable_get("@#{category}").include?(keyword) }
    Display.print_all(results)
  end
end
