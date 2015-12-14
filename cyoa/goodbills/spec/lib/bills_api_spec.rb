require 'spec_helper'
require 'bills_api'

describe "BillsAPI" do
  let(:example_data) do
    data = File.open("spec/lib/fake_data.json", "r", &:read)
    JSON.parse(data).with_indifferent_access
  end
  it "can transform and save api result" do
    Bill.delete_all
    BillsAPI.save example_data
    expect(Bill.all[0].bill_id).to eq("hr4236-114")
    expect(Bill.all[0].congress_url).not_to be_nil
  end
end
