class DinosaurInfo
  attr_accessor :dinosaurs, :dinosaurs_filtered, :filters

  def initialize(dinosaurs)
    @dinosaurs = dinosaurs
  end

  # options should be in the following format
  # { operator <string> => { attribute: value } }
  def filter_dinosaurs(options = {})
    dinosaurs_filtered = @dinosaurs
    @filters = options
    options.each do |operator, filters|
      filters.each do |key, value|
        dinosaurs_filtered =
            dinosaurs_filtered.select do |dinosaur|
              dinosaur.send("#{key}").send(operator, value)
            end
      end
    end
    @dinosaurs_filtered = dinosaurs_filtered
  end

  def to_s(include_filter = false)
    if include_filter
      dinosaurs = @dinosaurs_filtered
      title = "DinoDex current Dinosaur Info Last Filter (#{@filters}):"
    else
      dinosaurs = @dinosaurs
      title = "DinoDex current Dinosaur Info:"
    end
    to_s = title + "\n"
    to_s +=  "----------------------\n"
    dinosaurs.each do |dinosaur|
      to_s += dinosaur.to_s + "\n"
      to_s += "----------------------\n"
    end
    to_s
  end

  def json_export(include_filter = false)
    if include_filter
      dinosaurs = @dinosaurs_filtered
    else
      dinosaurs = @dinosaurs
    end
    dinosaurs.to_json
  end
end
