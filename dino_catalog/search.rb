require 'table_print'

class Search
  def self.find(keyword)
    result = Catalog.dinosaurs.find { |x| x.name == keyword }
    Display.print_one(result)
  end

  def self.select(category, keyword)
    results = Catalog.dinosaurs.find_all { |x| x.instance_variable_get("@#{category}").include?(keyword) }
    Display.print_all(results)
  end
end

# move to catalog and make instance var
