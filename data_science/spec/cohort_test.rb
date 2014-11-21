
describe Cohort do

	context "with only 1 cohort" do
		let(:visitor1) { Visitor.new({ date: '2014-03-20', cohort: "A", result: 0 }) }
		let(:visitor2) { Visitor.new({ date: '2013-12-29', cohort: "A", result: 1 }) }
		
		let(:cohort) { Cohort.new.add(visitor1).add(visitor2) }
		let(:empty_cohort) { Cohort.new }

		subject {'cohort'}

		it "has a total sample size of visitors" do
			expect(cohort.sample_size).to eq(2)
		end

		it "has 1 conversion" do
			expect(cohort.conversions).to eq(1)
		end

		it "has a percentage of conversion " do
			expect(cohort.conversion_percentage).to eq(0.5)
		end

		it "has a 0 percent conversion rate for no data" do
			expect(empty_cohort.conversion_percentage).to eq(0)
		end

		it "has a 95% confidence interval for the conversion rate" do
			expect(cohort.confidence_interval[0]).to be_within(1e-4).of(-0.1929)
			expect(cohort.confidence_interval[1]).to be_within(1e-4).of(1.1929)
		end
	end
end	

