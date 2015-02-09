require_relative '../calculator'
describe Calculator do
  context "happy" do
    let(:filepath) { 'test_data.json' }
    subject(:calculator) { Calculator.new(filepath) }

    it "should have a test data list" do
      expect(calculator.test_data_list).not_to be_empty
    end

    it "should calculate sample size" do
      sample_size = calculator.sample_size_data()
      expect(sample_size).to include(:A, :B)
      expect(sample_size).to include(A: 558)
      expect(sample_size).to include(B: 641)
      expect(sample_size).not_to include(:C, :D)
    end

    it "should calculate the number of conversions" do
      conversions = calculator.conversions_data()
      expect(conversions).to include(:A, :B)
      expect(conversions).to include(A: 22)
      expect(conversions).to include(B: 41)
      expect(conversions).not_to include(:C, :D)
    end

    it "should calculate the conversion rates" do
      conversion_rates = calculator.conversion_rates_data()
      expect(conversion_rates).to include(:A, :B)
      expect(conversion_rates).to include(A: ["2.33%", "5.56%"])
      expect(conversion_rates).to include(B: ["4.5%", "8.29%"])
      expect(conversion_rates).not_to include(:C, :D)
    end

    it "should calculate the confidence level" do
      expect(calculator).not_to be_confident
    end
  end

  context "sad" do
    let(:filepath) { 'bad_data.json' }

    it "should raise an error is the does not have 2 cohorts" do
      expect { Calculator.new(filepath) }.to raise_error
    end
  end
end
