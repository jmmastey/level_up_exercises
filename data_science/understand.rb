# parse this {"date":"2014-03-20","cohort":"B","result":0}
FILETOIMPORT = "data_export_2014_06_20_15_59_02.json"
require 'json'
require 'abanalyzer'

class DataScience
  def self.import
    file = File.read(FILETOIMPORT)
    @data_hash = JSON.parse(file)
    @sample = @data_hash.length
    puts "loaded #{@sample} sample\n\n"
  end

  def self.raw_results
    @a_converts = 0
    @b_converts = 0
    @a_count = 0
    @b_count = 0

    @data_hash.each do |k|
      if k["cohort"] == "A"
        @a_converts += k["result"].to_i
        @a_count += 1
      else
        @b_converts += k["result"].to_i
        @b_count += 1
      end
      @a_nonconverts = @a_count - @a_converts
      @b_nonconverts = @b_count - @b_converts
    end

    puts "A conversion: #{@a_converts} non converts: " +
      "#{@a_nonconverts} over #{@a_count} days"
    puts "B conversion: #{@b_converts} non converts: " +
      "#{@b_nonconverts} over #{@b_count} days"
    puts "Total Sample: #{@sample}\n\n"
  end

  def self.significant_difference?
    values = {}
    values[:asum] = { converted: @a_converts, not_converted: @a_nonconverts }
    values[:bsum] = { converted: @b_converts, not_converted: @b_nonconverts }
    @significant_difference = ABAnalyzer::ABTest.new values
    puts "Is there a difference between the groups?"
    puts "#{@significant_difference.different?} \n\n"
  end

  def self.confidence_level
    p = 0.95
    puts "Conversion rates with #{p} certain"
    puts "Group A"
    @a_conf_rang = ABAnalyzer.confidence_interval(
      @a_converts, @a_nonconverts, p)

    puts "Conversion range from #{@a_conf_rang[0]} to #{@a_conf_rang[1]}"
    puts "Group B"
    @b_conf_rang = ABAnalyzer.confidence_interval(
      @b_converts, @b_nonconverts, p)

    puts "Conversion range from #{@b_conf_rang[0]} to #{@b_conf_rang[1]}\n\n"
  end

  def self.chi_leader
    values = {}
    values[:asum] = { converted: @a_converts, not_converted: @a_nonconverts }
    values[:bsum] = { converted: @b_converts, not_converted: @b_nonconverts }
    tester = ABAnalyzer::ABTest.new values
    puts "Chi leader"
    puts "Chi-Square Test if less then 0.05, we cannot accept null hypothesis"

    puts tester.chisquare_p
  end
end

DataScience.import
DataScience.raw_results
DataScience.significant_difference?
DataScience.confidence_level
DataScience.chi_leader
