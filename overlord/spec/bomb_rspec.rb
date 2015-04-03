require_relative "spec_helper.rb"

describe Bomb do
  DEFAULT_ACTIVATION_CODE = "1234"
  DEFAULT_DEACTIVATION_CODE = "0000"
  CORRECT_ACTIVATION_CODE = "1234"
  CORRECT_DEACTIVATION_CODE = "0000"
  INCORRECT_ACTIVATION_CODE = "1111"
  INCORRECT_DEACTIVATION_CODE = "2222"
  RETRY_LIMIT = 3
  let(:bomb) { Bomb.new }
  
  it 'returns default activation code' do
    expect(Bomb.default_activation_code).to eq(DEFAULT_ACTIVATION_CODE)
  end
  
  it 'returns default deactivation code' do
    expect(Bomb.default_deactivation_code).to eq(DEFAULT_DEACTIVATION_CODE)
  end
  
  it 'returns retry limit' do
    expect(bomb.retry_limit).to eq(RETRY_LIMIT)
  end

  it 'returns retry count' do
    expect(bomb.retry_count).to eq(1)
  end

  it 'returns true for valid code' do
    expect(Bomb.valid_code?("1234")).to be true
  end

  it 'returns false for invalid code' do
    expect(Bomb.valid_code?("abcd")).to be false
  end
 
  it 'returns bomb status as ACTIVE for correct activation code' do
    bomb.activate(CORRECT_ACTIVATION_CODE)
    expect(bomb.status).to eq("ACTIVE")
  end
  
  it 'returns bomb status as INACTIVE for incorrect activation code' do
    bomb.activate(INCORRECT_ACTIVATION_CODE)
    expect(bomb.status).to eq("INACTIVE")
  end

  it 'returns bomb status as INACTIVE for correct deactivation code' do
    bomb.activate(CORRECT_DEACTIVATION_CODE)
    expect(bomb.status).to eq("INACTIVE")
  end

  it 'returns bomb status as ACTIVE for incorrect deactivation code' do
    bomb.activate(CORRECT_ACTIVATION_CODE)
    bomb.deactivate(INCORRECT_DEACTIVATION_CODE)
    expect(bomb.status).to eq("ACTIVE")
  end

  it 'returns bomb status as EXPLODE' do
    bomb.explode
    expect(bomb.status).to eq("EXPLODE")
  end
end
