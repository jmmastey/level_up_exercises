require 'rails_helper'

RSpec.describe Photo, type: :model do
  before(:each) do
    @new_photo = Photo.create(first: "t", last: "j", photo_url: "sfs@dfs.com")
  end

  describe "create a valid photo" do
    it 'create a photo', focus: true do
      photo = Photo.create

      photo.first = "JSON"
      photo.last = "Vorhees"
      photo.photo_url = "aaaaasfs@dfs.com"
      expect(photo).to be_valid
    end
    it 'cannot create a photo with duplicate url', focus: true do
      photo = Photo.create
      photo.first = "JSON"
      photo.last = "Vorhees"
      photo.photo_url = "sfs@dfs.com"
      expect(photo).not_to be_valid
    end
  end
end