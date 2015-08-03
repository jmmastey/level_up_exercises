require_relative '../cohort_statistics.rb'
require_relative '../data_statistics.rb'
require 'abanalyzer'

describe CohortStatistics do
	let(:data_stat){DataStatistics.new}
	let(:cohort_stat_A){CohortStatistics.new("A", data_stat.cohort_data)}

	context "setting a cohort group's size" do
		size = 11
		cohort_stat.cohort_size.should == size
	end

	context "calculating conversion freq for a cohort group" do
		converted = 5
		not_converted = 6
		cohort_stat.converted.should == converted
		cohort_stat.not_converted.should == not_converted
		cohort_stat.conversion_freq.should == .45
	end

	context "calculate confidence interval for a cohort group" do
		ab_confidence = ABAnalyzer.confidence_interval(cohort_stat.converted, 11, 0.95)
		ab_confidence.should == cohort_stat.cohort_confidence_interval
	end

	context "convert cohort stat to a chi square testable hash" do 
	end
end