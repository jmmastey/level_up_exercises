require "./arrow.rb"

module ArrowDb
  RAWDATA = [
    [:notched, "Archaic Side Notch", :far_west],
    [:stemmed, "Archaic Stemmed", :far_west],
    [:lanceolate, "Agate Basin", :far_west],
    [:bifurcated, "Cody", :far_west],
    [:notched, "Besant", :northern_plains],
    [:stemmed, "Archaic Stemmed", :northern_plains],
    [:lanceolate, "Humboldt Constricted Base", :northern_plains],
    [:bifurcated, "Oxbow", :northern_plains]
  ]

  ARROWHEADS = RAWDATA.map do |info|
    ArrowHead.new(type: info[0], name: info[1], region: info[2])
  end

  def self.find_arrowhead(params)
    found_arrowhead = ARROWHEADS.find do |arrowhead|
      arrowhead.type?(params[:type]) && arrowhead.from?(params[:region])
    end
    found_arrowhead || raise_not_found_error(params)
  end

  def self.raise_not_found_error(values)
    fail "Arrowhead not found with type of '#{values[:type]}' and region of '#{values[:region]}'"
  end
end
