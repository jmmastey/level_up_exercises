require_relative "dino"

class DinoCsvParser
  CATEGORY_REMAP = { "GENUS" => "NAME", "CARNIVORE" => "DIET",
                     "WEIGHT_IN_LBS" => "WEIGHT" }
  DIET_REMAP = { "Yes" => "Carnivore", "No" => "Herbivore" }

  def initialize
    @dinos = []
    @categories = []
  end

  def parse_file(filename)
    initialize
    File.open(filename) do |file|
      while (line = file.gets)
        parse_line(line)
      end
    end
    @dinos
  end

  private

  def parse_line(line)
    return parse_categories(line) if @categories.empty?

    @dinos << parse_data(line)
  end

  def parse_categories(line)
    @categories = line.strip.upcase.split(',')
    normalize_categories!
  end

  def normalize_categories!
    @categories.map! { |cat| CATEGORY_REMAP[cat] || cat }
  end

  def parse_data(line)
    dino = Dino.new
    params = line.strip.split(',')
    params.each_with_index do |param, i|
      category = @categories[i].downcase
      dino.send(category + '=', param)
    end
    dino
  end
end
