require_relative('json_parser.rb')

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = [:should, :expect]
  end
end

describe JSONParser do
  before do
    @parser = JSONParser.new
  end

  it 'should fail elegantly when the file does not exist' do
    @parser.parse('nope.json').should == {}
  end

  it 'should open simple files correctly' do
    @parser.parse('simple.json').should == {
        'hello' => 'world',
        'goodbye' => 'moon',
        'dog' => 'cat',
    }
  end

  it 'should correctly read an empty file' do
    @parser.parse('empty.json').should == {}
  end

  it 'should load an array of hashes correctly' do
    @parser.parse('array_of_hashes.json').should == [
        {'hello' => 'world'},
        {'goodbye' => 'moon'}
    ]
  end
end