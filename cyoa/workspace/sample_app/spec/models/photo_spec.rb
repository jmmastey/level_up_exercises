require 'rails_helper'

#RSpec.describe Photo, type: :model do
#  pending "add some examples to (or delete) #{__FILE__}"
#end

RSpec.describe Photo, type: :model do
  before(:each) do
    @new_photo = Photo.create(first: "t", last: "j", photo_url: "sfs@dfs.com")
    p @new_photo
  end

  describe "create a valid photo" do
    it 'create a photo', focus: true do
      photo = Photo.create
      photo.first = "JSON"
      photo.last = "Vorhees"
      photo.photo_url = "aaaasfs@dfs.com"
      #expect(@new_user.name).to eq("JSON Vorhees")
      expect(photo).to be_valid
      #expect(@new_user).to be_valid
    end
    it 'cannot create a photo from dupe url', focus: true do
      photo = Photo.create
      photo.first = "JSON"
      photo.last = "Vorhees"
      photo.photo_url = "sfs@dfs.com"
      #expect(@new_user.name).to eq("JSON Vorhees")
      expect(photo).not_to be_valid
      #expect(@new_user).to be_valid
    end


  end
end