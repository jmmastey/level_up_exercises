module DinosaurIndex
  module InputDecoders
    def decodeWeight(integer_string)
      integer_string.to_i
    end

    def decode_time_period(time_period_string)
      period_strings = /(?:(\w+)\s+)?(\w+)/.match(time_period_string)
      (part_of_period, period) =
        period_strings[1].to_sym, period_strings[2].to_sym
    end

    def decode_diet(diet_string)
      diet_string.downcase.to_sym
    end

    def decode_posture(posture_string)
      posture_string.downcase.to_sym
    end
  end
end
