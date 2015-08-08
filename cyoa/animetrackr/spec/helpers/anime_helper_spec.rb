require 'rails_helper'

RSpec.describe AnimeHelper, type: :helper do
  let(:rated_stars) { AnimeHelper::FILLED_IN }
  let(:unrated_stars) { AnimeHelper::NOT_FILLED_IN }

  describe('#output_stars') do
    it 'should fill in 5 stars for a rating of 5' do
      html = []
      5.times { html << rated_stars }
      expect(output_stars(5)).to eq(html.join)
    end

    it 'should fill in 4 stars and leave 1 unfilled for a rating of 4' do
      html = []
      4.times { html << rated_stars }
      1.times { html << unrated_stars }
      expect(output_stars(4)).to eq(html.join)
    end

    it 'should fill in 0 starts and leave 5 unfilled for a rating of 0' do
      html = []
      5.times { html << unrated_stars }
      expect(output_stars(0)).to eq(html.join)
    end
  end
end
