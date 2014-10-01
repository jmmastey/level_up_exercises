require 'rails_helper'

RSpec.describe "jobs/show", :type => :view do
  before(:each) do
    @job = assign(:job, Job.create!(
      :title => "Title",
      :location => "Location",
      :link => "MyText",
      :haveapplied => false,
      :company => "Company",
      :interested => false,
      :referred => "Referred"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Location/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/Company/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/Referred/)
  end
end
