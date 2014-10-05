require 'rails_helper'

RSpec.describe "events/index", type: :view do
  before(:each) do
    @events = FactoryGirl.create_list(:event, 2)
  end

  it "renders a list of events" do
    render
  end
end
