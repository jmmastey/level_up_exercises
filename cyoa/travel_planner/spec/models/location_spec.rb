require 'rails_helper'

describe Location, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:location)).to be_valid
  end

  it "has a valid o'hare location factory" do
    expect(FactoryGirl.create(:ohare_location)).to be_valid
  end

  it "requires state" do
    expect { FactoryGirl.create(:location, state: "") }.to raise_error
  end

  it "requires postal_code" do
    expect { FactoryGirl.create(:location, postal_code: "") }.to raise_error
  end

  it "requires address1" do
    expect { FactoryGirl.create(:location, address1: "") }.to raise_error
  end

  it "requires city" do
    expect { FactoryGirl.create(:location, city: "") }.to raise_error
  end
end
