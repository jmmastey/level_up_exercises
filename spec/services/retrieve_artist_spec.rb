require "rails_helper"

describe RetrieveArtist do
  let(:artist_retriever) { RetrieveArtist.new(File.read("spec/support/data_files/warhol.json")) }

  it "retrieves data on an Artist and create a new artist" do
    allow(artist_retriever).to receive(:artist_name)
      .and_return("Andy Warhol")

    expect(artist_retriever.artist_name).to eq("Andy Warhol")
  end

  describe "#parse_name" do
    it "parses the JSON data and returns the artists's name" do
      expect(artist_retriever.artist_name).to eq("Andy Warhol")
    end
  end

  describe "#parse_nationality" do
    it "parses the JSON data and returns the artist's nationality" do
      expect(artist_retriever.nationality).to eq("American")
    end
  end

  describe "#parse_birthday" do
    it "parses the JSON data and returns the artist's nationality" do
      expect(artist_retriever.birthday).to eq("1928")
    end
  end

  describe "#parse_biography" do
    it "parses the JSON data and returns the artist's biography" do
      expect(artist_retriever.biography).to include("An American painter,")
    end
  end

  describe "#parse_analysis" do
    it "parses the JSON data and returns the analysis on the artist" do
      expect(artist_retriever.analysis).to include("Obsessed with celebrity")
    end
  end

end
