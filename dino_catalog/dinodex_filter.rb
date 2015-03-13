require './dino_parser'

class DinodexFilter
  def initialize(files = ['dinodex.csv', 'african_dinosaur_export.csv'])
    @last_result = []
    @dino_catalog = DinoParser.parse(files)
    @filtered_catalog = @dino_catalog
  end

  def filter(attribute, value = nil)
    @last_result = @filtered_catalog.filter(attribute, value)
  end

  def update_filtered_catalog
    @filtered_catalog = @last_result unless @last_result.empty?
    puts 'chain updated'
  end

  def reset_filtered_catalog
    @filtered_catalog = @dino_catalog
    puts 'chain reset'
  end

  def print_last_result
    @last_result.print
  end
end
