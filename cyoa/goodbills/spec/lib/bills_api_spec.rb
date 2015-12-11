require 'spec_helper'
require 'bills_api'

describe "BillsAPI" do
  it "can transform and save api result" do
    example_data = {bill_id: "hr4236-114", bill_type: "hr", chamber: "house",
      committee_ids: ["HSWM"], congress: 114, cosponsors_count: 16,
      enacted_as: nil, history: {active: false, awaiting_signature: false, 
      enacted: false, vetoed: false}, introduced_on: "2015-12-10",
      last_action_at: "2015-12-10", last_version_on: "2015-12-10", 
      last_vote_at: nil, number: 4236,
      official_title: "To promote savings by providing a tax credit for eligible",
      popular_title: nil, related_bill_ids: [],
      short_title: nil, sponsor: {first_name: "José", last_name: "Serrano", 
      middle_name: "E.", name_suffix: nil, nickname: nil, title: "Rep"}, 
      sponsor_id: "S000248", urls: {congress: "http://beta.congress.gov/bill/114th/",
      govtrack: "https://www.govtrack.us/congress/bills/114/hr4236",
      opencongress: "https://www.opencongress.org/bill/hr4236-114"}, 
      withdrawn_cosponsors_count: 0}.with_indifferent_access
    Bill.delete_all  
    BillsAPI.save example_data
    expect(Bill.all[0].bill_id).to eq("hr4236-114")
    expect(Bill.all[0].congress_url).not_to be_nil
  end
end