require 'rails_helper'

RSpec.describe "event_dates/index", type: :view do
  before(:each) do
    @event_dates = FactoryGirl.create_list(:event_date, 2)
  end

  it "renders a list of event_dates" do
    render
  end
end
