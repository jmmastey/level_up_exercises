require_relative('bomb.rb')

describe Bomb do
  before do
    @bomb = Bomb.new
  end

  it 'should be inactive to start' do
    expect(@bomb.status_reader).to eq('Inactive')
  end

  it 'should default the activation code to 1234' do
    @bomb.activate('1234')
    expect(@bomb.status_reader).to eq('Active')
  end

  it 'should default the deactivation code to 0000' do
    @bomb.activate('1234')
    @bomb.deactivate('0000')
    expect(@bomb.status_reader).to eq('Deactivated')
  end

  it 'should work with a different activation code' do
    @bomb = Bomb.new('0000', '1111')
    @bomb.activate('0000')
    expect(@bomb.status_reader).to eq('Active')
  end

  it 'should work with a different deactivation code' do
    @bomb = Bomb.new('0000', '1111')
    @bomb.activate('0000')
    @bomb.deactivate('1111')
    expect(@bomb.status_reader).to eq('Deactivated')
  end

  it 'should blow up after three incorrect deactivation attempts' do
    @bomb.activate('1234')
    3.times { @bomb.deactivate('1111') }
    expect(@bomb.status_reader).to eq('Blown Up')
  end

  it 'should deactivate after two attempts' do
    @bomb.activate('1234')
    2.times { @bomb.deactivate('1111') }
    @bomb.deactivate('0000')
    expect(@bomb.status_reader).to eq('Deactivated')
  end

  it 'should correctly validate codes' do
    expect(Bomb.valid_code?('1234')).to be true
  end

  it 'should correctly filter invalid code' do
    expect(Bomb.valid_code?('Hello')).to be false
  end

  it 'should accept empty as a valid code' do
    expect(Bomb.valid_code?('')).to be true
  end
end
