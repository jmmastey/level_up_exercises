require_relative 'objects_filter'

class DinosaurInfo
  attr_accessor :dinosaurs, :dinosaurs_filtered, :filters_applied
  TO_S_LINE = "----------------------\n"

  def initialize(d)
    @dinosaurs = d
  end

  # filters should be in the following format
  # { operator <string> => { attribute: value } }
  def filter_dinosaurs(filters = {})
    self.dinosaurs_filtered = ObjectsFilter::filter_objects(filters, dinosaurs)
    self.filters_applied = filters
  end

  def to_s(include_filter = false)
    dinosaurs_selected = include_filter ? dinosaurs_filtered : dinosaurs
    output = to_s_title(include_filter) + $/ + TO_S_LINE
    output << to_s_dinosaurs(dinosaurs_selected)
  end

  def to_s_title(include_filter = false)
    if include_filter
      "DinoDex current Dinosaur Info Last Filter (#{filters_applied}):"
    else
      "DinoDex current Dinosaur Info:"
    end
  end

  def to_s_dinosaurs(dinosaurs_selected)
    dinosaurs_selected.map { |dinosaur_selected| dinosaur_selected.to_s + $/ + TO_S_LINE }.join("")
  end

  def to_json(include_filter = false)
    if include_filter
      dinosaurs_filtered.to_json
    else
      dinosaurs.to_json
    end
  end
end
