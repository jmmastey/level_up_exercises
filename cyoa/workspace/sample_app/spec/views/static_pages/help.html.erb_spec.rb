require 'rails_helper'

RSpec.describe "photos/new.html.erb", type: :view do
  before do
    render
    #expect(rendered).to eql("Finder")
  end

  describe "#PageContent" do
    it 'displays the word Dave', focus: true do
      #rendered.should have_content('Find')
      expect(rendered).to match(/Dave/)
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
