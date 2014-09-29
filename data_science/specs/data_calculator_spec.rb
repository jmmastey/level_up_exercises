require_relative '../lib/data_calculator.rb'


describe DataCalculator do

 data = [{"date"=>"2014-03-20", "cohort"=>"B", "result"=>1}, 
				{"date"=>"2014-03-20", "cohort"=>"B", "result"=>0}, 
				{"date"=>"2014-03-20", "cohort"=>"B", "result"=>0}, 
				{"date"=>"2014-03-20", "cohort"=>"B", "result"=>0},
				{"date"=>"2014-03-20", "cohort"=>"A", "result"=>0}, 
				{"date"=>"2014-03-20", "cohort"=>"A", "result"=>1},
				{"date"=>"2014-03-20", "cohort"=>"B", "result"=>1}, 
				{"date"=>"2014-03-20", "cohort"=>"B", "result"=>0}, 
				{"date"=>"2014-03-20", "cohort"=>"B", "result"=>1}
]

  describe  "#conversion_rate" do
	  @calculator = DataCalculator.new(data)
		it "should calculate conversion of A or B" do
		 expect(average_word_length(string)).to be_within(0.01).of 
		end
	 end
end





















 #   describe  "#conversion_rate" do
	# it "should calculate conversion of B" do


	# end
 # end
  

	# it "should calculate standard_error of A" do


	# end

	# it "should calculate standard_error of B" do


	# end

	# it "should calculate confidence_interval of A" do


	# end

	# it "should calculate confidence_interval of B" do


	# end
# end

    #  it should calculate conversion of B
	# it should provide conversion for a given time period
	# it should calculate bounce rate
	# it should calculate standard error
	# 
