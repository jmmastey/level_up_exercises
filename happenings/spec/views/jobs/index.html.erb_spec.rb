require 'rails_helper'

RSpec.describe "jobs/index", :type => :view do
  before(:each) do
    assign(:jobs, [
      Job.create!(
        :title => "Title",
        :location => "Location",
        :link => "MyText",
        :haveapplied => false,
        :company => "Company",
        :interested => false,
        :referred => "Referred"
      ),
      Job.create!(
        :title => "Title",
        :location => "Location",
        :link => "MyText",
        :haveapplied => false,
        :company => "Company",
        :interested => false,
        :referred => "Referred"
      )
    ])
  end

  it "renders a list of jobs" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Location".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "Company".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "Referred".to_s, :count => 2
  end
end
