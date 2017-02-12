require 'table_print'
require 'export'

include Export

class Catalog
  attr_accessor :items

  def initialize
    @items = []
  end

  def find_big
    p "BIG Dinosaurs"
    @results = @items.select { |x| x.weight >= 2000 }
    self
  end

  def find_small
    p "Small Dinosaurs"
    @results = @items.select { |x| x.weight < 2000 }
    self
  end

  def filter(category, keyword)
    p "Filter by #{category} for #{keyword}"
    current_items = @results ? @results : @items

    @results = current_items.select do |x|
      x.instance_variable_get("@#{category}").include?(keyword)
    end
    self
  end

  def search_with_hash(h)
    p "hash search"
    @results = nil
    carry = []
    h.each_pair do |key, value|
      carry = filter(key, value)
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

  def print_sizes
    p "Complete catalog"
    @items.each do |x|
      puts x.name
      puts x.what_size
      puts "-" * 50 + "\n"
    end
    p "end of entire catalog"
  end
end
