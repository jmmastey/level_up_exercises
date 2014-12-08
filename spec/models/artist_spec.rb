require 'rails_helper'

RSpec.describe Artist, :type => :model do

  describe '#full_name' do
    let(:artist) { FactoryGirl.create(:artist, first_name: "Claude", last_name: "Monet") }

    it 'returns the full name of the artist' do

      expect(artist.full_name).to eq("Claude Monet")
    end
  end
end
