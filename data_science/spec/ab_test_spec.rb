require_relative "../ab_test.rb"


describe ABTestCalculator::ABTest do

  let(:abtest) do
    abtest = ABTestCalculator::ABTest.new
    abtest.group_A.add_nonconverts(data[:a_nc]).add_converts(data[:a_c])
    abtest.group_B.add_nonconverts(data[:b_nc]).add_converts(data[:b_c])
    abtest
  end

  context "with negative test" do
    let(:data) { {a_nc: 22418, a_c: 1035, b_nc: 3411, b_c: 153} }

    it "computes valid chi-square statistic" do
      expect(abtest.chi_square_value).to be_within(0.001).of(0.106)
    end

    it "properly fails to reject null hypothesis" do
      expect(abtest.significant_95_confidence).to be_falsey
    end
  end

  context "with positive test" do
    let(:data) { {a_nc: 1302, a_c: 47, b_nc: 1434, b_c: 79} }

    it "properly rejects the null hypothesis" do
      expect(abtest.significant_95_confidence).to be_truthy
    end
  end
end
