require 'rails_helper'

describe Type do
  it "has a valid factory" do
    expect(create(:type)).to be_valid
  end

  it "is invalid without a name" do
    expect(build(:type, name: nil)).to_not be_valid
  end

  it "does not allow duplicate names" do
    type = create(:type)
    expect(build(:type, name: type.name)).to_not be_valid
  end
end
