require 'rails_helper'

RSpec.describe Meeting, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:meeting)).to be_valid
  end

  it "requires start" do
    expect { FactoryGirl.create(:meeting, start: "") }.to raise_error
  end

  it "requires length" do
    expect { FactoryGirl.create(:meeting, length: "") }.to raise_error
  end

  it "requires location" do
    expect { FactoryGirl.create(:meeting, location: "") }.to raise_error
  end
end
