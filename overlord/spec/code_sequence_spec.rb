require_relative '../code_sequence.rb'

RSpec.describe CodeSequence do
  DEFAULT_CODE = '1234'
  VALID_CODE = '9264'
  INVALID_NUMERIC_CODE = '92et'
  INVALID_LENGTH_CODE = '973'

  before :example do
    @code = CodeSequence.new DEFAULT_CODE
  end

  it 'raises an error when initialized with invalid default code' do
    bad_init = -> { CodeSequence.new(INVALID_LENGTH_CODE) }
    expect(bad_init).to raise_error(RuntimeError)
  end

  it 'uses the default code when given code is less than 4 chars' do
    expect(@code.set INVALID_LENGTH_CODE).to be false
    expect(@code.code).to eq(DEFAULT_CODE)
  end

  it 'uses the default code when given code is not numeric' do
    expect(@code.set INVALID_NUMERIC_CODE).to be false
    expect(@code.code).to eq(DEFAULT_CODE)
  end

  it 'uses the given code when its valid' do
    expect(@code.set VALID_CODE).to be true
    expect(@code.code).to eq(VALID_CODE)
  end

  it 'can compare its default code after invalid entry'  do
    @code.set INVALID_NUMERIC_CODE
    expect(@code.is? INVALID_NUMERIC_CODE).to be false
    expect(@code.is? DEFAULT_CODE).to be true
  end

  it 'can compare its user set code after valid entry' do
    @code.set VALID_CODE
    expect(@code.is? DEFAULT_CODE).to be false
    expect(@code.is? VALID_CODE).to be true
  end
end