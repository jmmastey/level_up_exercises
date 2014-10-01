require 'rails_helper'

RSpec.describe "jobs/new", :type => :view do
  before(:each) do
    assign(:job, Job.new(
      :title => "MyString",
      :location => "MyString",
      :link => "MyText",
      :haveapplied => false,
      :company => "MyString",
      :interested => false,
      :referred => "MyString"
    ))
  end

  it "renders new job form" do
    render

    assert_select "form[action=?][method=?]", jobs_path, "post" do

      assert_select "input#job_title[name=?]", "job[title]"

      assert_select "input#job_location[name=?]", "job[location]"

      assert_select "textarea#job_link[name=?]", "job[link]"

      assert_select "input#job_haveapplied[name=?]", "job[haveapplied]"

      assert_select "input#job_company[name=?]", "job[company]"

      assert_select "input#job_interested[name=?]", "job[interested]"

      assert_select "input#job_referred[name=?]", "job[referred]"
    end
  end
end
