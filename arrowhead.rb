require_relative 'classifications.rb'
# This is the main class for the exercise
class Arrowhead
  @classify_class = Classify.new
  # This seriously belongs in a database.
  CLASSIFICATIONS = {
    far_west: {
      notched: 'Archaic Side Notch',
      stemmed: 'Archaic Stemmed',
      lanceolate: 'Agate Basin',
      bifurcated: 'Cody'
    },
    northern_plains: {
      notched: 'Besant',
      stemmed: 'Archaic Stemmed',
      lanceolate: 'Humboldt Constricted Base',
      bifurcated: 'Oxbow'
    }
  }

  # FIXME: I don't have time to deal with this.
  def self.classify(region, shape)
    @classify_class.get_shapes(CLASSIFICATIONS, region, shape)
  end
end

puts Arrowhead.classify(:northern_plains, :bifurcated)
