require 'table_print'
require 'export'

include Export

class Catalog
  attr_accessor :items

  def initialize
    @items = []
  end

  def find_one(keyword)
    @items.find { |x| x.name == keyword }
  end

  def filter(category, keyword)
    @results = @items.find_all do |x|
      x.instance_variable_get("@#{category}").include?(keyword)
    end
    self
  end

  def print_filter
    @results.each { |x| puts x.to_s }
    p "end of filter"
  end

  def print_all
    p "Complete catalog"
    @items.each { |x| puts x.to_s }
    p "end of entire catalog"
  end
end
