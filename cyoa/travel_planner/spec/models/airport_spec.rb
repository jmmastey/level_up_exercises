require 'rails_helper'

describe Airport, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:airport)).to be_valid
  end

  it "has a valid O'Hare factory" do
    expect(FactoryGirl.create(:ohare)).to be_valid
  end

  it "requires name" do
    expect { FactoryGirl.create(:airport, name: "") }.to raise_error
  end

  it "requires code" do
    expect { FactoryGirl.create(:airport, code: "") }.to raise_error
  end

  it "requires location" do
    expect { FactoryGirl.create(:airport, location: "") }.to raise_error
  end
end
