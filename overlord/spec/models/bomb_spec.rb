require_relative '../spec_helper'

describe 'bomb' do
  let(:bomb) { Bomb.create }

  let (:valid_bomb) { Bomb.create(activation_code: '12342',
                        deactivation_code: '10220',
                        detonation_time: '55') }


  it "should have default activation code" do
    expect(bomb.activation_code).to eq("1234")
  end

  it "should have default deactivation code" do
    expect(bomb.deactivation_code).to eq("0000")
  end

  it "should have activation code configurable" do
    expect(valid_bomb.activation_code).to eq("12342")
  end

  it "should have default deactivation code" do
    expect(valid_bomb.deactivation_code).to eq("10220")
  end
end