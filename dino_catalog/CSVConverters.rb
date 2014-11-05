module CSVConverters
    ::CSV::HeaderConverters[:conv_genus] = lambda{|h| 
      begin
        return 'Name' if h.downcase == 'genus'
        return h
      end
    }

    ::CSV::HeaderConverters[:conv_weight] = lambda{|h| 
      begin
        return 'Weight' if h.downcase == 'weight_in_lbs'
        return h
      end
    }
end