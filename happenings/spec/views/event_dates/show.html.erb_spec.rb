require 'rails_helper'

RSpec.describe "event_dates/show", :type => :view do
  before(:each) do
    @event_date = assign(:event_date, EventDate.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
