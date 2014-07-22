require './lib/splitalizer'

describe Splitalizer do

	# it "responds to foo_test" do
	# 	data = SplitalizerDataLoader.parse("./source_data.json")
	# 	splital = Splitalizer.new(data)
	# 	expect(splital.foo_test()).to eq("blah")
	# end
	#
	# it "is not cool" do
	# 	data = SplitalizerDataLoader.parse("./source_data.json")
	# 	splital = Splitalizer.new(data)
	# 	expect(splital.cool?).to be_falsey
	# 	expect(splital).not_to be_cool
	# end

	it "produces the correct optimal solution" do
		data = SplitalizerDataLoader.parse("./source_data.json")
		splital = Splitalizer.new(data)
		expect(splital.winning_group).to eq("B")
	end

end
