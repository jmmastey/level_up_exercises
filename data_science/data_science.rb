require 'json'
require 'ABAnalyzer'

class DataScience
  def initializer(_args = {})
    @visits = []
  end

  def open_and_read_file(file_path)
    file = File.open(file_path, "r")
    data = file.read
    file.close
    data
  end

  def parse_json_file(file_path)
    # return if !File.exists?(file_path)

    json_data = open_and_read_file(file_path)

    @visits = JSON.parse(json_data)
  end

  def successfully_loaded?
    return false if @visits.nil? || @visits.empty?
    true
  end

  def find_counts_per_cohort
    @cohort_a_count = 0
    @cohort_b_count = 0
    @cohort_a_conv_count = 0
    @cohort_b_conv_count = 0

    @visits.each do |visit|
      cohort_for_visit = visit['cohort']
      conversion_for_visit = visit['result']

      case cohort_for_visit
        when 'A'
          @cohort_a_count += 1
          @cohort_a_conv_count += conversion_for_visit
        when 'B'
          @cohort_b_count += 1
          @cohort_b_conv_count += conversion_for_visit
        else
          next
      end
    end
  end

  def able_to_find_cohort_counts?
    return true if @cohort_a_count != 0 && @cohort_b_count != 0
    false
  end

  def calculate_average_conversion_rate
    @avg_rate_a = 0.0
    @avg_rate_b = 0.0

    @avg_rate_a = @cohort_a_conv_count.to_f / @cohort_a_count.to_f
    @avg_rate_b = @cohort_b_conv_count.to_f / @cohort_b_count.to_f
  end

  def able_to_calculate_avg_conv_rate?
    return false if @avg_rate_a == 0 || @avg_rate_b == 0
    true
  end

  def calculate_95_perc_conversion_rate_range(cohort)
    case cohort
      when "A"
        @rate_a_low_range = 0
        @rate_a_high_range = 0

        result = ABAnalyzer.confidence_interval(@cohort_a_conv_count,
                                                @cohort_a_count, 0.95)
        @rate_a_low_range = result[0]
        @rate_a_high_range = result[1]
      when "B"
        @rate_b_low_range = 0
        @rate_b_high_range = 0

        result = ABAnalyzer.confidence_interval(@cohort_b_conv_count,
                                                @cohort_b_count, 0.95)
        @rate_b_low_range = result[0]
        @rate_b_high_range = result[1]
    end
  end

  def able_to_calculate_95_conv_rate_ranges?
    if @rate_a_low_range == 0 || @rate_a_high_range == 0 ||
       @rate_b_low_range == 0 || @rate_b_high_range == 0
      return false
    end
    true
  end

  def calculate_confidence_level
    values = {}
    values['a'] = { 'conved' => @cohort_a_conv_count,
                    'unconved' => @cohort_a_count - @cohort_a_conv_count }
    values['b'] = { 'conved' => @cohort_b_conv_count,
                    'unconved' => @cohort_b_count - @cohort_b_conv_count }

    analyzer = ABAnalyzer::ABTest.new values

    @confidence_level = 0
    @confidence_level = analyzer.chisquare_p
  end

  def able_to_produce_confidence_level?
    return true if @confidence_level != 0
    false
  end

  def show_avg_rates
    # presentable values.
    avg_rate_a_pres = @avg_rate_a * 100
    conv_count_a_pres = @cohort_a_conv_count * 100
    count_a_pres = @cohort_a_count * 100

    avg_rate_b_pres = @avg_rate_b * 100
    conv_count_b_pres = @cohort_b_conv_count * 100
    count_b_pres = @cohort_b_count * 100

    puts "Avg A Rate: " + avg_rate_a_pres.round(2).to_s + "% (" +
      conv_count_a_pres.to_s + "/" + count_a_pres.to_s + ")"
    puts "Avg B Rate: " + avg_rate_b_pres.round(2).to_s + "% (" +
      conv_count_b_pres.to_s + "/" + count_b_pres.to_s + ")"
  end

  def show_rates_ranges
    # presentable values
    a_low_pres = @rate_a_low_range * 100
    a_high_pres = @rate_a_high_range * 100

    b_low_pres = @rate_b_low_range * 100
    b_high_pres = @rate_b_high_range * 100

    puts "A Rates: [" + a_low_pres.round(2).to_s + "% - " +
      a_high_pres.round(2).to_s + "%]"
    puts "B Rates: [" + b_low_pres.round(2).to_s + "% - " +
      b_high_pres.round(2).to_s + "%]"
  end

  def show_confidence_level
    # presentable values
    conf_pres = @confidence_level * 100

    puts "Confidence Level: " + conf_pres.round(2).to_s + "%"
  end
end

file_path = './data_export_2014_06_20_15_59_02.json'
data_science = DataScience.new

data_science.parse_json_file(file_path)
data_science.find_counts_per_cohort

data_science.calculate_average_conversion_rate
data_science.calculate_95_perc_conversion_rate_range("A")
data_science.calculate_95_perc_conversion_rate_range("B")
data_science.calculate_confidence_level

data_science.show_avg_rates
data_science.show_rates_ranges
data_science.show_confidence_level
