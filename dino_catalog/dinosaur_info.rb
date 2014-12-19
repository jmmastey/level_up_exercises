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
    self.dinosaurs_filtered = ObjectsFilter.filter_objects(filters, dinosaurs)
    self.filters_applied = filters
  end

  def to_s(include_filter = false)
    dinos = include_filter ? dinosaurs_filtered : dinosaurs
    output = to_s_title(include_filter) + $RS + TO_S_LINE
    output << dinosaurs_to_s(dinos)
  end

  def to_s_title(include_filter = false)
    if include_filter
      "DinoDex current Dinosaur Info Last Filter (#{filters_applied}):"
    else
      "DinoDex current Dinosaur Info:"
    end
  end

  def dinosaurs_to_s(dinos)
    dinos.map { |dino| dinosaur_line(dino) }.join("")
  end

  def dinosaur_line(dino)
    dino.to_s + $RS + TO_S_LINE
  end

  def to_json(include_filter = false)
    if include_filter
      dinosaurs_filtered.to_json
    else
      dinosaurs.to_json
    end
  end
end
