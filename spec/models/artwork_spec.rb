require 'rails_helper'

RSpec.describe Artwork, :type => :model do

  describe "Create new artwork" do
    it "validates a new valid artwork" do
      artwork = Artwork.new
      artwork.title = "Nighthawks"
      artwork.date = "1-1-2015"

      expect(artwork).to be_valid
    end

    it "does not validate a new invalid artwork" do
      artwork = Artwork.new
      artwork.title = "Nighthawks"
      artwork.date = ""

      artwork.valid?

      expect(artwork).not_to be_valid
    end
  end

  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:date) }
  end

  describe "associations" do
    it { should belong_to(:artist) }
  end
end
