$LOAD_PATH << '.'

require 'objects_filter'

class DinosaurInfo
  attr_accessor :dinosaurs, :dinosaurs_filtered, :filters
  TO_S_LINE = "----------------------\n"

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
    dinosaurs = include_filter ? @dinosaurs_filtered : @dinosaurs
    to_s = to_s_title(include_filter) + $/ + TO_S_LINE
    to_s += to_s_dinosaurs(dinosaurs)
    to_s
  end

  def to_s_title(include_filter = false)
    if include_filter
      "DinoDex current Dinosaur Info Last Filter (#{@filters}):"
    else
      "DinoDex current Dinosaur Info:"
    end
  end

  def to_s_dinosaurs(dinosaurs)
    to_s_dinosaurs = ""
    dinosaurs.each do |dinosaur|
      to_s_dinosaurs += dinosaur.to_s + $/ + TO_S_LINE
    end
    to_s_dinosaurs
  end

  def to_json(include_filter = false)
    if include_filter
      @dinosaurs_filtered.to_json
    else
      @dinosaurs.to_json
    end
  end
end
