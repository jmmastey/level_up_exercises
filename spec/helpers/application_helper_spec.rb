require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the ArtistsHelper. For example:
#
# describe ArtistsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe ApplicationHelper, :type => :helper do

  describe "markdown" do
    let(:markdown_text) { "This is *bongos*, indeed." }

    it "outputs markdown into HTML" do
      expect(markdown(markdown_text)).to eq("<p>This is <em>bongos</em>, indeed.</p>\n")
    end
  end
end
