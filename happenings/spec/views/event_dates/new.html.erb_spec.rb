require 'rails_helper'

RSpec.describe "event_dates/new", type: :view do
  before(:each) do
    @event_date = FactoryGirl.build(:event_date)
  end

  it "renders new event_date form" do
    render

    assert_select "form[action=?][method=?]", event_dates_path, "post" do
    end
  end
end
