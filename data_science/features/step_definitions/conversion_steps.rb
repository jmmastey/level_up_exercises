require_relative '../../data_science.rb'

Given(/^a sample with ([a-z]+) data$/) do |a|
  if(a == 'appropriate')
    @raw_data = JSON.parse(File.read('/Users/bsubramanian/level_up_exercises/data_science/sample_data.json'))
    @ds = DataScience.new(@raw_data)
  end
end

When(/^conversion rate formula is applied$/) do
  begin
  @conversion_rate = @ds.calculate_conversion_rate
  rescue RuntimeError => e
    @err = e
  end
end

When(/^raw data is parsed$/) do
  @cp = CohortParser.new(@raw_data)
  @cohorts = @cp.convert_to_cohorts
end

Then(/^it returns (\d+) cohorts$/) do |arg1|
  @cohorts.size.should == 2
  @cohorts.should == {"A"=>{:hits=>10, :attempts=>16}, 
    "B"=>{:hits=>9, :attempts=>15}}
end

Then(/^it returns a valid result$/) do
  @ds.conversion[0].should >  0
end

Then(/^it raises an error "([^"]*)"$/) do |arg1|
  @ds.conversion[0].should == nil
  @err.message.should == arg1
  #pending # Write code here that turns the phrase above into concrete actions
end
