require 'rspec'
require 'bomb'

describe 'Activate bomb' do
  before(:each) do
    @bomb = Bomb.new
  end

  let(:code_error) { "code must be 4 numbers" }
  let(:good_code) { "1234" }
  let(:short_code) { "123" }
  let(:empty_code) { "" }
  let(:alpha_code) { "asdf" }
  let(:wrong_code) { "5678" }

  def activate(activation_code, deactivation_code)
    @bomb.activate(activation_code, deactivation_code)
  end

  it 'should activate with good code' do
    activate(good_code, good_code)
    expect(@bomb).to be_activated
  end

  it 'should fail to activate with no activation code' do
    expect { activate(empty_code, good_code) }.to raise_error(/#{code_error}/)
  end

  it 'should fail to activate with no deactivation code' do
    expect { activate(good_code, empty_code) }.to raise_error(/#{code_error}/)
  end

  it 'should fail to activate with short activation code' do
    expect { activate(short_code, good_code) }.to raise_error(/#{code_error}/)
  end

  it 'should fail to activate with short deactivation code' do
    expect { activate(good_code, short_code) }.to raise_error(/#{code_error}/)
  end

  it 'should fail to activate with non numeric activation code' do
    expect { activate(alpha_code, good_code) }.to raise_error(/#{code_error}/)
  end

  it 'should fail to activate with non numeric deactivation code' do
    expect { activate(good_code, alpha_code) }.to raise_error(/#{code_error}/)
  end

  it 'should fail to activate when already activated' do
    @bomb.activate(good_code, good_code)
    expect { activate(good_code, good_code) }.to raise_error(Bomb::BombError)
  end

  it 'should fail to activate when already exploded' do
    @bomb.activate(good_code, good_code)
    Bomb::MAX_ATTEMPTS.times { @bomb.deactivate(wrong_code) }
    expect(@bomb).to be_exploded
    expect { @bomb.activate(good_code, good_code) }.to \
      raise_error(Bomb::BombError)
  end

end

describe 'Deactivate bomb' do
  before(:each) do
    @bomb = Bomb.new
  end

  let(:good_code) { "1234" }
  let(:wrong_code) { "5678" }

  it 'should deactivate when I enter the correct code' do
    @bomb.activate(good_code, good_code)
    @bomb.deactivate(good_code)
    expect(@bomb).to_not be_activated
    expect(@bomb).to_not be_exploded
  end

  it 'should not deactivate when I enter the wrong code' do
    @bomb.activate(good_code, good_code)
    @bomb.deactivate(wrong_code)
    expect(@bomb).to be_activated
    expect(@bomb).to_not be_exploded
  end

  it 'should deactivate when I enter the right code on the last attempt' do
    @bomb.activate(good_code, good_code)
    (Bomb::MAX_ATTEMPTS - 1).times { @bomb.deactivate(wrong_code) }
    @bomb.deactivate(good_code)
    expect(@bomb).to_not be_activated
    expect(@bomb).to_not be_exploded
  end
end

describe 'Explosive scenarios' do
  before(:each) do
    @bomb = Bomb.new
  end

  let(:good_code) { "1234" }
  let(:wrong_code) { "5678" }

  it 'should explode when I enter the wrong code too many times' do
    @bomb.activate(good_code, good_code)
    Bomb::MAX_ATTEMPTS.times { @bomb.deactivate(wrong_code) }
    expect(@bomb).to be_exploded
  end

  it 'should not work when exploded' do
    @bomb.activate(good_code, good_code)
    Bomb::MAX_ATTEMPTS.times { @bomb.deactivate(wrong_code) }
    expect(@bomb).to be_exploded
    expect { @bomb.deactivate(good_code) }.to raise_error(Bomb::BombError)
  end
end
