module CSVConverters

    CSV::HeaderConverters[:conv_genus] = lambda{|h| 
      begin 
        :name if h == :genus
      rescue ArgumentError
        h
      end
    }

    CSV::HeaderConverters[:conv_weight] = lambda{|h| 
      begin 
        :weight if h == :weight_in_lbs
      rescue ArgumentError
        h
      end
    }
end