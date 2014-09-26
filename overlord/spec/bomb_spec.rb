require 'rspec'
require 'bomb'

describe 'Activate bomb' do
  before(:each) do
    @bomb = Bomb.new
  end

  let(:code_error) {"code must be 4 numbers"}
  let(:good_code) { "1234" }
  let(:short_code) {"123"}
  let(:empty_code) {""}
  let(:alpha_code) {"asdf"}

  it 'should activate with good code' do
    expect(@bomb.activate(good_code, good_code)).to be_truthy
  end

  it 'should fail to activate with no activation code' do
    expect { @bomb.activate(empty_code, good_code) }.to raise_error(/#{code_error}/)
  end

  it 'should fail to activate with no deactivation code' do
    expect { @bomb.activate(good_code, empty_code) }.to raise_error(/#{code_error}/)
  end

  it 'should fail to activate with short activation code' do
    expect { @bomb.activate(short_code, good_code) }.to raise_error(/#{code_error}/)
  end

  it 'should fail to activate with short deactivation code' do
    expect { @bomb.activate(good_code, short_code) }.to raise_error(/#{code_error}/)
  end

  it 'should fail to activate with non numeric activation code' do
    expect { @bomb.activate(alpha_code, good_code) }.to raise_error(/#{code_error}/)
  end

  it 'should fail to activate with non numeric deactivation code' do
    expect { @bomb.activate(good_code, alpha_code) }.to raise_error(/#{code_error}/)
  end

  it 'should fail to activate when already activated' do
    @bomb.activate(good_code,good_code)
    expect { @bomb.activate(good_code, good_code) }.to raise_error(/already activated/)
  end
end
