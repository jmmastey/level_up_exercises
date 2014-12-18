require 'spec_helper'

describe Bill do
  let (:fake) { FactoryGirl.build(:bill) }

  it "has a short title" do
    expect(fake.short_title).to eq(fake.title)
  end

  it "has a bill id when no short title is available" do
    fake.short_title = nil
    expect(fake.bill_id).to eq(fake.title)
  end
end
