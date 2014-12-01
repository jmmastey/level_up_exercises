require 'spec_helper'

describe Legislator do
  it "has a full name" do
    fake = FactoryGirl.build(:legislator,
                             title: 'Mrs.',
                             first_name: 'Pac',
                             last_name: 'Man',
                             nickname: nil,
                             party: nil)
    assert_equal fake.full_name, "Mrs. Pac Man"
  end

  it "has a full party affiliation" do
    fake = FactoryGirl.build(:legislator, party: "D")
    assert_equal fake.full_party, "Democrat"
  end
end
