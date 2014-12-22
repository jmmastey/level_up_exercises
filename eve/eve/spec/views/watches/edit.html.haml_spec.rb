require 'rails_helper'

RSpec.describe "watches/edit", type: :view do
  let(:watch) { FactoryGirl.create(:watch) }

  before(:each) { assign(:watch, watch) }

  it "renders the watch form" do
    stub_template("watches/_form.html.haml" => "watch_form")
    render
    expect(rendered).to match(/watch_form/)
  end
end
