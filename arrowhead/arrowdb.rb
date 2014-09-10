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
    return found_arrowhead unless found_arrowhead.nil?
    arrowhead_not_found(values)
  end

  def self.arrowhead_not_found(values)
    fail "Arrowhead not found with type of '#{values[:type]}' and region of '#{values[:region]}'"
  end
end
