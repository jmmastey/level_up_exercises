require 'table_print'
require 'export'

include Export

class Catalog
  attr_accessor :items

  def initialize
    @items = []
  end

  def find_one(keyword)
    result = @items.find { |x| x.name == keyword }
    Display.print_one(result)
  end

  def select_all(category, keyword)
    results = @items.find_all { |x| x.instance_variable_get("@#{category}").include?(keyword) }
    Display.print_all(results)
  end
end
