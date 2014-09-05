require 'rspec'
require './jsonparser'

describe JSONParser, "#dumpString" do
  it "takes in a given string and escapes quotes for json" do
    parser = JSONParser.new
    
    raw_strings = [ 
      'a', 'te st', '"', "test\n", 'a"b"c',
      '\\"a'
    ]
    parsed = raw_strings.map {|str| parser.dump(str) }

    expect(parsed[0]).to eq('"a"')
    expect(parsed[1]).to eq('"te st"')
    expect(parsed[2]).to eq('"""')
    expect(parsed[3]).to eq('"test\n"')
    expect(parsed[4]).to eq('"a"b"c"')
    expect(parsed[5]).to eq('"\\\\"a"')
  end
end
