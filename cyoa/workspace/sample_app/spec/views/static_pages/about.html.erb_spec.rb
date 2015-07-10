require 'rails_helper'

RSpec.describe "static_pages/about.html.erb", type: :view do
  before(:each) do
    render
    #expect(rendered).to eql("Finder")
  end

  describe "#PageContent" do
    it 'displays the word find', focus: true do
      #rendered.should have_content('Find')
      expect(rendered).to match(/About/)
    end
  end

  describe "#PageContent" do
    it 'displays the word CNUapp', focus: true do
      expect(rendered).to match(/sample/)
      #rendered.should have_content('CNUapp')
    end
  end

  describe "#PageContent" do
    it 'contains SampleApp', focus: true do
      expect(rendered).to have_content("tutorial")
    end
  end
end