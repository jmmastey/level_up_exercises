require_relative "spec_helper.rb"
describe DataAnalyzer do
  TEST_FILE = 'test_data_b.json'
  let(:data_analyzer) { DataAnalyzer.new(TEST_FILE) }
  
  it 'initializes successfully' do
    expect {data_analyzer}.not_to raise_error
  end
  it 'calculates and returns confidence leveli of 0.96' do
    expect(data_analyzer.calculate_confidence_level).to eq(0.96)
  end
end
