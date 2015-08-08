require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the AnimeLibraryHelper. For example:
#
# describe AnimeLibraryHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe AnimeLibraryHelper, type: :helper do
  describe('#get_ratings_options') do
    it 'should return the selectable ratings choices for a user' do
      ratings = [[0, 0], [1, 1], [2, 2], [3, 3], [4, 4], [5, 5]]
      expect(ratings_options).to eq(ratings)
    end
  end
end
