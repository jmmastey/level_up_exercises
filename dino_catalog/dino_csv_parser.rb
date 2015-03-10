class DinoCsvParser
  attr_reader :dinos

  def parse_file(filename)
    @dinos = []
    @categories = nil

    File.open(filename) do |file|
      while (line = file.gets)
        parse_line(line)
      end
    end
  end

  def parse_line(line)
    if @categories.nil?
      parse_categories(line)
    else
      @dinos << parse_data(line)
    end
  end

  def parse_categories(line)
    @categories = line.strip.upcase.split(',')
    normalize_categories!
  end

  def normalize_categories!
    @categories[0] = "NAME" if @categories[0] == "GENUS"

    idx = @categories.index("WEIGHT_IN_LBS")
    @categories[idx] = "WEIGHT" if idx
  end

  def parse_data(line)
    params = line.strip.split(',')
    paired_params = params.each_with_index.map do |param, i|
      category_data_pair(param, @categories[i])
    end

    Hash[paired_params]
  end

  def category_data_pair(param, category)
    if category == "CARNIVORE"
      param == "Yes" ? %w(DIET Carnivore) : %w(DIET Non-Carnivore)
    else
      [category, param]
    end
  end
end
