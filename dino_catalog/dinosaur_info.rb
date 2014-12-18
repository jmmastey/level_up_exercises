$LOAD_PATH << '.'

require 'objects_filter'

class DinosaurInfo
  attr_accessor :dinosaurs, :dinosaurs_filtered, :filters

  def initialize(dinosaurs)
    @dinosaurs = dinosaurs
  end

  # filters should be in the following format
  # { operator <string> => { attribute: value } }
  def filter_dinosaurs(filters = {})
    @dinosaurs_filtered = ObjectsFilter::filter_objects(filters, @dinosaurs)
    @filters = filters
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

  def to_json(include_filter = false)
    if include_filter
      @dinosaurs_filtered.to_json
    else
      @dinosaurs.to_json
    end
  end
end
