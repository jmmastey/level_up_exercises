class ABTestCalculator
  class ABTestGroup
    attr_accessor :converts
    attr_accessor :nonconverts
     
    STDERRS_95_CONFIDENCE = 1.96

    def initialize(options = {})
      @converts = options[:converts] || 0
      @nonconverts = options[:nonconverts] || 0
    end

    def add_nonconverts(howmany)
      @nonconverts += howmany
    end

    def add_converts(howmany)
      @converts += howmany
    end

    def visitors
      converts + nonconverts
    end

    def conversion_ratio
      converts.to_f / visitors
    end

    def standard_error
      cr = conversion_ratio
      Math.sqrt(cr * (1 - cr) / visitors)
    end

    def error_margin
      standard_error * STDERRS_95_CONFIDENCE
    end

    def confidence_interval_95
      Range.new(conversion_ratio - error_margin,
                conversion_ratio + error_margin)
    end
  end
end
