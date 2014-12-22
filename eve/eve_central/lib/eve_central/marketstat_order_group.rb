require "active_model"

module EveCentral
  class MarketstatOrderGroup
    include ActiveModel::Validations
    include ActiveModel::Conversion
    extend ActiveModel::Naming

    attr_accessor :average,
                  :maximum,
                  :median,
                  :minimum,
                  :percentile,
                  :standard_deviation,
                  :volume

    validates_numericality_of :average,
                              :median,
                              greater_than_or_equal_to: :minimum,
                              less_than_or_equal_to: :maximum
    validates_numericality_of :maximum,
                              greater_than_or_equal_to: :minimum
    validates_numericality_of :minimum,
                              :standard_deviation,
                              greater_than_or_equal_to: 0
    validates_numericality_of :percentile,
                              greater_than_or_equal_to: 0,
                              less_than_or_equal_to: 100
    validates_numericality_of :volume,
                              only_integer: true,
                              greater_than_or_equal_to: 0

    def initialize(statistics = {})
      @average = statistics[:average]
      @maximum = statistics[:maximum]
      @median = statistics[:median]
      @minimum = statistics[:minimum]
      @percentile = statistics[:percentile]
      @standard_deviation = statistics[:standard_deviation]
      @volume = statistics[:volume]
    end

    def persisted?
      false
    end
  end
end
