require 'rails_helper'

RSpec.describe AnimeLibraryHelper, type: :helper do
  describe('#get_ratings_options') do
    it 'should return the selectable ratings choices for a user' do
      ratings = [[0, 0], [1, 1], [2, 2], [3, 3], [4, 4], [5, 5]]
      expect(ratings_options).to eq(ratings)
    end
  end
end
