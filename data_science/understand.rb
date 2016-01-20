# parse this {"date":"2014-03-20","cohort":"B","result":0}
FILETOIMPORT = "data_export_2014_06_20_15_59_02.json"
require 'json'
require 'abanalyzer'

class DataScience
  # A. The data set is a JSON file exported from the database (because Postgres
  # does JSON now and someone went a little overboard). You'll need to parse the input file.
  # However, make sure the data loading is abstracted from the main calculation code.
  def import
    file = File.read(FILETOIMPORT)
    @data_hash = JSON.parse(file)
    puts "loaded #{@data_hash.length} sample"
  end

  # B. For a given experiment, we're looking to calculate the conversion rate of visitors as part of a split test. We care about the following factors:

  # 1. Total sample size and number of conversions for each cohort.
  def raw_results
    a_group = 0
    b_group = 0

    @data_hash.each do |k|
      if k["cohort"] == "A"
        a_group += k["result"].to_i
      else
        b_group += k["result"].to_i
      end
    end

    puts "A group: #{a_group}"
    puts "B group: #{b_group}"
  end

  #   2. Conversion rate (including error bars) for each cohort with a 95% confidence.
  def significant_difference?
    values = {}
    values[:agroup] = { converted: 47, not_converted: 2892 }
    values[:bgroup] = { converted: 79, not_converted: 2892 }
    tester = ABAnalyzer::ABTest.new values
    puts tester.different?
  end

  # 3. Confidence level that the current leader is in fact better than random.
  # You should use the Chi-square test for this, feel free to cheat with a [simple calculator](http://www.usereffect.com/split-test-calculator)
  # to get your initial calculations. Feel free to use a gem to perform the calculations in your code; gems are good.
  def confidence
    puts ABAnalyzer.confidence_interval(27, 2892, 0.95)
  end
end
