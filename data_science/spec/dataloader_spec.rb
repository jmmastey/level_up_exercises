require_relative '../data_loader'
require_relative '../traffic'

describe DataLoader do

  it "File should be valid and will be read in" do
    my_data = DataLoader.new("../smalldata.json")
    data_in = my_data.read_in_json

    expect(data_in).to eql(
    [{ "date" => "2014-03-20", "cohort" => "B", "result" => 0 },
     { "date" => "2014-03-20", "cohort" => "B", "result" => 1 },
     { "date" => "2014-03-20", "cohort" => "A", "result" => 0 },
     { "date" => "2014-03-20", "cohort" => "A", "result" => 1 }])
  end

  it "File is not valid and a NotAJSONFileError comes up" do
    no_json = "../smalldata.jsn"
    my_data = DataLoader.new(no_json)
    expect { my_data.read_in_json }.to raise_error(NotAJSONFileError)
  end

  it "File is not valid and a FileDoesNotExistError Error comes up" do
    no_file = "../smalldat.json"
    my_data = DataLoader.new(no_file)
    expect { my_data.read_in_json }.to raise_error(FileDoesNotExistError)
  end

  it "Data Objects are built" do
    my_data = DataLoader.new("../smalldata.json")
    my_data.read_in_json
    expect(my_data.build_data).to eql(
    [{ "date" => "2014-03-20", "cohort" => "B", "result" => 0 },
     { "date" => "2014-03-20", "cohort" => "B", "result" => 1 },
     { "date" => "2014-03-20", "cohort" => "A", "result" => 0 },
     { "date" => "2014-03-20", "cohort" => "A", "result" => 1 }])
  end

  it "Sample json data is seperated into groups"do
    my_data = DataLoader.new("../smalldata.json")
    my_data.read_in_json
    my_data.build_data
    group1, group2 = my_data.seperate_groups
    expect(group1).not_to be_empty
    expect(group1.size).to be(2)
    expect(group2).not_to be_empty
    expect(group2.size).to be(2)
  end

end
