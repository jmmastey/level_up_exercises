module CSVConverters
  ::CSV::HeaderConverters[:conv_genus] = lambda do|h|
    begin
      return 'Name' if h.downcase == 'genus'
      return h
    end
  end

  ::CSV::HeaderConverters[:conv_weight] = lambda do |h|
    begin
      return 'Weight' if h.downcase == 'weight_in_lbs'
      return h
    end
  end
end
