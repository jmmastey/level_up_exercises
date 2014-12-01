require 'spec_helper'

describe Bill do
  before :each do
    @fake = FactoryGirl.build(:bill)
  end

  it "has a short title" do
    assert_equal @fake.short_title, @fake.title
  end

  it "has a bill id when no short title is available" do
    @fake.short_title = nil
    assert_equal @fake.bill_id, @fake.title
  end
end
