require 'rails_helper'

RSpec.describe "events/edit", type: :view do
  before(:each) do
    @event = FactoryGirl.create(:event)
  end

  it "renders the edit event form" do
    render

    assert_select "form[action=?][method=?]", event_path(@event), "post" do
    end
  end
end
