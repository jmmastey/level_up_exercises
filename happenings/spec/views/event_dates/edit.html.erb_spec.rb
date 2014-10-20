require 'rails_helper'


RSpec.describe "event_dates/edit", type: :view do
  before(:each) do
    @event_date = FactoryGirl.create(:event_date)
  end

  it "renders the edit event_date form" do
    render

    action_method = "form[action=?][method=?]"
    assert_select action_method, event_date_path(@event_date), "post" do
    end
  end
end
