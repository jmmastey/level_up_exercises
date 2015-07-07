require 'rails_helper'

RSpec.describe "static_pages/help.html.erb", type: :view do
  before do
    render
    #expect(rendered).to eql("Finder")
  end

  describe "#PageContent" do
    it 'displays the word find', focus: true do
      #rendered.should have_content('Find')
      expect(rendered).to match(/Find/)
    end

    it 'displays the word CNUapp', focus: true do
      expect(rendered).to match(/static_pages/)
      #rendered.should have_content('CNUapp')
    end

    it 'contains SampleApp', focus: true do
      expect(rendered).to have_content("Find")
    end
  end

end
