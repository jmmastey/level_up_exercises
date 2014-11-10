module CsvConverters
  ::CSV::HeaderConverters[:conv_genus] = lambda do|h|
    begin
      h.downcase == 'genus' ? (return'Name') : h
    end
  end

  ::CSV::HeaderConverters[:conv_weight] = lambda do |h|
    begin
      h.downcase == 'weight_in_lbs' ? (return 'Weight') : h
    end
  end
end
