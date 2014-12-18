require 'spec_helper'

describe Legislator do
  it "has a full name" do
    fake = FactoryGirl.build(:legislator,
                             title: 'Mrs.',
                             first_name: 'Pac',
                             last_name: 'Man',
                             nickname: nil,
                             party: nil)
    expect(fake.full_name).to eq("Mrs. Pac Man")
  end

  it "has a full party affiliation" do
    fake = FactoryGirl.build(:legislator, party: "D")
    expect(fake.full_party).to eq("Democrat")
  end
end
