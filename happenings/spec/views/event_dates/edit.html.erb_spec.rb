require 'rails_helper'

RSpec.describe "event_dates/edit", :type => :view do
  before(:each) do
    @event_date = assign(:event_date, EventDate.create!())
  end

  it "renders the edit event_date form" do
    render

    assert_select "form[action=?][method=?]", event_date_path(@event_date), "post" do
    end
  end
end
