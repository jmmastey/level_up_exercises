require 'rails_helper'

RSpec.describe "event_dates/new", :type => :view do
  before(:each) do
    assign(:event_date, EventDate.new())
  end

  it "renders new event_date form" do
    render

    assert_select "form[action=?][method=?]", event_dates_path, "post" do
    end
  end
end
