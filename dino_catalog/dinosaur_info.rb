class DinosaurInfo
  attr_accessor :dinosaurs, :dinosaurs_filtered,:filters

  def initialize(dinosaurs)
    @dinosaurs = dinosaurs
  end

  # options should be in the following format
  # { operator <string> => { attribute: value } }
  def filter_dinosaurs(options={})
    @dinosaurs_filtered = @dinosaurs
    @filters = options
    options.each do |operator, filters|
      filters.each do |key, value|
        @dinosaurs_filtered = @dinosaurs_filtered.select { |dinosaur| dinosaur.send("#{key}").send(operator,value) }
      end
    end
    @dinosaurs_filtered
  end

  def print_dinosaurs_info(include_filter=false)
      if include_filter
        dinosaurs = @dinosaurs_filtered
        title = "DinoDex current Dinosaur Info Last Filter (#{@filters}):"
      else
        dinosaurs = @dinosaurs
        title = "DinoDex current Dinosaur Info:"
      end
      puts title
      puts "----------------------"
      dinosaurs.each do |dinosaur|
        dinosaur.print_dinosaur_info
        puts "----------------------"
      end
  end

  def json_export(include_filter=false)
    if include_filter
      dinosaurs = @dinosaurs_filtered
    else
      dinosaurs = @dinosaurs
    end
    dinosaurs.to_json
  end

end
