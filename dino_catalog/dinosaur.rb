class Dinosaur

  attr_reader :taxon        # Name of dinosaur
  attr_reader :time_period  # When dinosaur lived
  attr_reader :weight       # Weight of animals in lbs
  attr_reader :ambulation   # Mode of locomotion
  attr_reader :description  # Human-readable informational message

  def initialize(taxon, period, diet, weight, ambulation, description = nil)

    @taxon, @period, @diet, @weight, @ambulation, @description =
      taxon, period, diet, weight, ambulation, description
  end
end
