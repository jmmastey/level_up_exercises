require 'abanalyzer'

class DataManager
  @sample_size = 0
  attr_accessor :reader
  def load(reader)
    @reader = reader
  end

  def total_sample_size(cohort_name = nil)
    if @reader.nil?
      0
    else if cohort_name.nil?
           @reader.data_hash.count
         else
           @reader.data_hash.count { |item| (item['cohort']) == cohort_name }

         end
    end
  end

  def total_conversion_size(cohort_name = nil)
    if @reader.nil?
      0
    else if cohort_name.nil?
           @reader.data_hash.count { |item| (item['result']) == 1 }
         else
           @reader.data_hash.count { |item| (item['cohort']) == cohort_name && (item['result'] == 1) }
         end
    end
  end

  def conversion_rate(cohort = nil)
    if @reader.nil?
      0
    else
      converted = total_conversion_size(cohort)
      total = total_sample_size(cohort)
      ((converted.to_f / total.to_f) * 100).round(2)
    end
  end

  def calculate_chi_square
    values = {}
    a_1 = total_conversion_size("A")
    a_0 = total_sample_size("A") - a_1
    b_1 = total_conversion_size("B")
    b_0 = total_sample_size("B") - a_1

    values[:agroup] = { convert: a_1, no_convert: a_0 }
    values[:bgroup] = { convert: b_1, no_convert: b_0 }

    values[:agroup] = { convert: a_1, no_convert: a_0 }
    values[:bgroup] = { convert: b_1, no_convert: b_0 }

    tester = ABAnalyzer::ABTest.new values
    # if this number is smaller than 0.05 we are good
    tester.chisquare_p.round(3)
  end
end
