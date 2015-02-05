require_relative '../calculator'
describe Calculator do
  filepath = 'test_data.json'
  calculator = Calculator.new
  calculator.setup_data(filepath)

  it "should have a test data list" do
    expect(calculator.test_data_list.count).to be > 0
  end

  it "should calculate sample size" do
    sample_size = calculator.sample_size
    expect(sample_size).to include(:A, :B)
    expect(sample_size).to include(A: 558)
    expect(sample_size).to include(B: 641)
    expect(sample_size).not_to include(:C, :D)
  end

  it "should calculate the number of conversions" do
    conversions = calculator.conversions
    expect(conversions).to include(:A, :B)
    expect(conversions).to include(A: 22)
    expect(conversions).to include(B: 41)
    expect(conversions).not_to include(:C, :D)
  end

  it "should calculate the conversion rates" do
    conversion_rates = calculator.conversion_rates
    expect(conversion_rates).to include(:A, :B)
    expect(conversion_rates).to include(A: ["2.33%", "5.56%"])
    expect(conversion_rates).to include(B: ["4.5%", "8.29%"])
    expect(conversion_rates).not_to include(:C, :D)
  end

  it "should calculate the confidence level" do
    expect(calculator.confident?).to eq(false)
  end
end
