require_relative "spec_helper"

CUSTOM_ARM_CODE = "5555"
INCORRECT_ARM_CODE = "1111"
CUSTOM_DISARM_CODE = "6666"
INCORRECT_DISARM_CODE = "2222"
INVALID_CODE = "xyz"

describe Bomb do
  let(:default_bomb) { Bomb.new }
  let(:custom_bomb) { Bomb.new(CUSTOM_ARM_CODE, CUSTOM_DISARM_CODE) }

  it "should initialize successfully" do
    expect { Bomb.new }.not_to raise_error
  end
  it "should have default arm code of '1234'" do
    default_bomb.process_code("1234")
    expect(default_bomb.armed?).to eq(true)
  end
  it "should have default disarm code of '0000'" do
    default_bomb.process_code("1234")
    expect(default_bomb.armed?).to eq(true)
    default_bomb.process_code("0000")
    expect(default_bomb.inactive?).to eq(true)
  end
  it "should support initialization with custom arm and disarm codes" do
    expect { Bomb.new(CUSTOM_ARM_CODE, CUSTOM_DISARM_CODE) }.not_to raise_error
  end
  it "should not initialize if a non-numeric arm code is supplied" do
    expect { Bomb.new(INVALID_CODE, CUSTOM_DISARM_CODE) }.to raise_error
  end
  it "should not initialize if a non-numeric disarm code is supplied" do
    expect { Bomb.new(CUSTOM_ARM_CODE, INVALID_CODE) }.to raise_error
  end
  it "should boot in the inactive state" do
    expect(default_bomb.inactive?).to eq(true)
  end
  it "should activate if the correct activation code is submitted" do
    custom_bomb.process_code(CUSTOM_ARM_CODE)
    expect(custom_bomb.armed?).to eq(true)
  end
  it "should remain active if the correct activation code is submitted again" do
    2.times { |_| custom_bomb.process_code(CUSTOM_ARM_CODE) }
    expect(custom_bomb.armed?).to eq(true)
  end
  it "should not activate if an incorrect activation code is submitted" do
    custom_bomb.process_code(INCORRECT_ARM_CODE)
    expect(custom_bomb.armed?).to eq(false)
  end
  it "should not activate if an invalid activation code is submitted" do
    custom_bomb.process_code(INVALID_CODE)
    expect(custom_bomb.armed?).to eq(false)
  end
  it "should deactivate if the correct deactivation code is submitted" do
    custom_bomb.process_code(CUSTOM_ARM_CODE)
    custom_bomb.process_code(CUSTOM_DISARM_CODE)
    expect(custom_bomb.inactive?).to eq(true)
  end
  it "should not deactivate if an invalid deactivation code is submitted" do
    custom_bomb.process_code(CUSTOM_ARM_CODE)
    custom_bomb.process_code(INVALID_CODE)
    expect(custom_bomb.armed?).to eq(true)
  end
  it "should not deactivate if an incorrect deactivation code is submitted" do
    custom_bomb.process_code(CUSTOM_ARM_CODE)
    custom_bomb.process_code(INCORRECT_DISARM_CODE)
    expect(custom_bomb.armed?).to eq(true)
  end
  it "should explode if an incorrect deactivation code is submitted three times" do
    custom_bomb.process_code(CUSTOM_ARM_CODE)
    3.times do
      expect(custom_bomb.armed?).to eq(true)
      custom_bomb.process_code(INCORRECT_DISARM_CODE)
    end

    expect(custom_bomb.exploded?).to eq(true)
  end
  it "should not be able to be activated once exploded" do
    custom_bomb.process_code(CUSTOM_ARM_CODE)
    3.times { custom_bomb.process_code(INCORRECT_DISARM_CODE) }
    custom_bomb.process_code(CUSTOM_ARM_CODE)
    expect(custom_bomb.exploded?).to eq(true)
  end
  it "should not be able to be deactivated once exploded" do
    custom_bomb.process_code(CUSTOM_ARM_CODE)
    3.times { custom_bomb.process_code(INCORRECT_DISARM_CODE) }
    custom_bomb.process_code(CUSTOM_DISARM_CODE)
    expect(custom_bomb.exploded?).to eq(true)
  end
end
