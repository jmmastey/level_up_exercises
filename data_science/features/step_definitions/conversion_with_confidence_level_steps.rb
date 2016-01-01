#Given(/^a sample of valid data$/) do
#  @ds = DataScience.new([:hits => 40,:sample_size => 100])   
#end

Given(/^a confidence level is assigned$/) do
  @confidence_level = 0.95
end

When(/^Results are calculated$/) do
  @result = @ds.calculate_conversion_rate_with_confidence_level(@confidence_level)
  @ds.calculate_error_rates 
end

Then(/^it returns a range of values$/) do
  @result[0].should be_an Array
  @result[0].map{|x| x.round(3)}.should == [0.388, 0.862] 
end

Then(/^it returns a valid error rate$/) do
  @ds.error_rates[0].should > 0 
end
