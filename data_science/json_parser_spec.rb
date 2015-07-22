require_relative('json_parser.rb')

describe JSONParser do
  before do
    @parser = JSONParser.new
  end

  it 'should fail elegantly when the file does not exist' do
    expect { @parser.parse('json_test_files/nope.json') }.to \
      raise_error(ArgumentError, 'File does not exist')
  end

  it 'should open simple files correctly' do
    expect(@parser.parse('json_test_files/simple.json')).to \
      eq('hello' => 'world', 'goodbye' => 'moon', 'dog' => 'cat')
  end

  it 'should correctly read an empty file' do
    expect(@parser.parse('json_test_files/empty.json')).to eq({})
  end

  it 'should load an array of hashes correctly' do
    expect(@parser.parse('json_test_files/array_of_hashes.json')).to eq([
      { 'hello' => 'world' },
      { 'goodbye' => 'moon' },
    ])
  end
end
