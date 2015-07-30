require_relative '../bomb.rb'

RSpec.describe Bomb do
  before :example do
    @bomb = Bomb.new
  end

  it 'initializes with empty code sequences' do
    expect(@bomb.activation_code.code).to be_nil
    expect(@bomb.deactivation_code.code).to be_nil
  end
end
