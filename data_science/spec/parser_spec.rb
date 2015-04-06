require_relative 'spec_helper'

describe Parser do
  it "should parse the given json file" do
    data = Parser.parse('sample_data.json')
    expect data.nil?
  end

  it "should raise an error if the file doesn't exist" do
    expect { Parser.parse('no_file') }.to raise_error(RuntimeError)
    expect { Parser.parse('no_file') }.to raise_error('File not found')
  end

  it "should raise an error if the json format is not correct" do
    expect { Parser.parse('unformatted_data.json') }.to raise_error(JSON::ParserError)
  end
end
