require 'rails_helper'

RSpec.describe "events/show", type: :view do
  before(:each) do
    @event = FactoryGirl.create(:event)
  end

  it "renders attributes in <p>" do
    render
  end
end
