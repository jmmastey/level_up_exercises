require 'rails_helper'

RSpec.describe "event_dates/index", :type => :view do
  before(:each) do
    assign(:event_dates, [
      EventDate.create!(),
      EventDate.create!()
    ])
  end

  it "renders a list of event_dates" do
    render
  end
end
