class ABTest
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
      self
    end

    def add_converts(howmany)
      @converts += howmany
      self
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

    def to_text(group_name = nil)
      ci = confidence_interval_95
      printf_args = [conversion_ratio, standard_error,
                     error_margin, ci.begin, ci.end]

      format <<EOH, *printf_args
---- Group#{group_name ? " #{group_name}" : ''} ---------------------
Visitors:         #{visitors}
Conversions:      #{converts}
Conversion ratio: %0.4f
Standard Error:   %0.4f
Error Margin:     %0.4f (%0.4f - %0.4f)

EOH
    end
  end
end
