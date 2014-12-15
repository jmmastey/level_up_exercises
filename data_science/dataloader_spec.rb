require_relative 'dataloader.rb'
require_relative 'data.rb'

describe DataLoader do

  it "File should be valid and will be read in" do
    data_in = DataLoader.read_in_json("smalldata.json")

    expect(data_in).to eql(
    [{ "date" => "2014-03-20", "cohort" => "B", "result" => 0 },
     { "date" => "2014-03-20", "cohort" => "B", "result" => 1 },
     { "date" => "2014-03-20", "cohort" => "A", "result" => 0 },
     { "date" => "2014-03-20", "cohort" => "A", "result" => 1 }])
  end

  it "File is not valid and a NotAJSONFileError comes up" do
    no_json = "smalldata.jsn"
    expect { DataLoader.read_in_json(no_json) }.to raise_error(NotAJSONFileError)
  end

  it "File is not valid and a FileDoesNotExistError Error comes up" do
    no_file = "smalldat.json"
    expect { DataLoader.read_in_json(no_file) }.to raise_error(FileDoesNotExistError)
  end

  it "Data Objects are built" do
    @data_in = DataLoader.read_in_json("smalldata.json")
    parse_content = DataLoader.build_data(@data_in)

    expect(parse_content).to eql(
    [{ "date" => "2014-03-20", "cohort" => "B", "result" => 0 },
     { "date" => "2014-03-20", "cohort" => "B", "result" => 1 },
     { "date" => "2014-03-20", "cohort" => "A", "result" => 0 },
     { "date" => "2014-03-20", "cohort" => "A", "result" => 1 }])
  end

  it "Sample json data is seperated into groups"do
    @data_in = DataLoader.read_in_json("smalldata.json")
    DataLoader.build_data(@data_in)
    group1, group2 = DataLoader.seperate_groups

    expect(group1).not_to be_empty
    expect(group1.size).to be(2)
    expect(group2).not_to be_empty
    expect(group2.size).to be(2)
  end

end
