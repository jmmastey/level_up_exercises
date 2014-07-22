require './lib/splitalize'

describe Splitalize do

	it "responds to foo_test" do
		data = SplitalizeDataLoader.parse("./source_data.json")
		splital = Splitalize.new(data)
		expect(splital.foo_test()).to eq("blah")
	end

	it "is not cool" do
		data = SplitalizeDataLoader.parse("./source_data.json")
		splital = Splitalize.new(data)
		expect(splital.cool?).to be_falsey
		expect(splital).not_to be_cool
	end

	it "doesn't know how to do this"

	xit "doesn't run this test" do

	end



end
