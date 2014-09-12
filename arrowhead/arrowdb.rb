require "./arrow.rb"

module ArrowDb
  ARROWHEADS = [
    ArrowHead.new(type: :notched, name: "Archaic Side Notch", region: :far_west),
    ArrowHead.new(type: :stemmed, name: "Archaic Stemmed", region: :far_west),
    ArrowHead.new(type: :lanceolate, name: "Agate Basin", region: :far_west),
    ArrowHead.new(type: :bifurcated, name: "Cody", region: :far_west),
    ArrowHead.new(type: :notched, name: "Besant", region: :northern_plains),
    ArrowHead.new(type: :stemmed, name: "Archaic Stemmed", region: :northern_plains),
    ArrowHead.new(type: :lanceolate, name: "Humboldt Constricted Base", region: :northern_plains),
    ArrowHead.new(type: :bifurcated, name: "Oxbow", region: :northern_plains)
  ]

  def self.find_arrowhead(values)
    arrowheads = ARROWHEADS.to_enum
    found_arrowhead = arrowheads.find do |arrowhead|
      arrowhead.type == values[:type] && arrowhead.region == values[:region]
    end
    found_arrowhead || raise_not_found_error(values)
  end

  def self.raise_not_found_error(values)
    fail "Arrowhead not found with type of '#{values[:type]}' and region of '#{values[:region]}'"
  end
end
