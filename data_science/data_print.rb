class DataPrint
  def self.print_avg_rates(avg_rate_a, a_count, a_c_count,
                           avg_rate_b, b_count, b_c_count)
    print_avg_rate('A', avg_rate_a, a_count, a_c_count)
    print_avg_rate('B', avg_rate_b, b_count, b_c_count)
  end

  def self.print_rates_ranges(a_low, a_high, b_low, b_high)
    print_rate('A', a_low, a_high)
    print_rate('B', b_low, b_high)
  end

  def self.print_confidence_level(conf_level)
    conf_pres = conf_level * 100
    puts "Confidence Level: #{conf_pres.round(2)}%"
  end

  def self.print_avg_rate(name, avg_rate, count, conv_count)
    avg_rate_pres = avg_rate * 100
    conv_count_pres = conv_count * 100
    count_pres = count * 100
    puts "Avg #{name} Rate: #{avg_rate_pres.round(2)}% (#{conv_count_pres}/#{count_pres})"
  end

  def self.print_rate(name, low, high)
    low_pres = low * 100
    high_pres = high * 100
    puts "#{name} Rates: [#{low_pres.round(2)}% - #{high_pres.round(2)}%]"
  end
end
