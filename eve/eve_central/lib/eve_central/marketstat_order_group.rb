module EveCentral
  class MarketstatOrderGroup
    attr_reader :average, :maximum, :median, :minimum, :percentile,
      :standard_deviation, :volume

    def initialize(statistics = {})
      @average = statistics[:average]
      @maximum = statistics[:maximum]
      @median = statistics[:median]
      @minimum = statistics[:minimum]
      @percentile = statistics[:percentile]
      @standard_deviation = statistics[:standard_deviation]
      @volume = statistics[:volume]
    end
  end
end
