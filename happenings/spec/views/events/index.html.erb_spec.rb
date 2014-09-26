require 'rails_helper'

RSpec.describe "events/index", :type => :view do
  before(:each) do
    assign(:events, [
      Event.create!(),
      Event.create!()
    ])
  end

  it "renders a list of events" do
    render
  end
end
