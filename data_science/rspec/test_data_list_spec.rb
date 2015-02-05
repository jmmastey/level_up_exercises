require_relative '../test_data_list'

describe TestDataList do
  test_data_list = TestDataList.new
  json_file_path = "test_data.json"

  test_data_list.parse(json_file_path)

  it "should parse a json file of test result data" do
    expect(test_data_list.count).to be > 0
  end

  it "should not have any results without a cohort" do
    expect(test_data_list.select { |result| result.cohort.nil? }.count).to eq(0)
  end

  it "should not have any results without a date" do
    expect(test_data_list.select { |result| result.date.nil? }.count).to eq(0)
  end

  it "should not have any results without a cohort" do
    expect(test_data_list.select { |result| result.result.nil? }.count).to eq(0)
  end
end
