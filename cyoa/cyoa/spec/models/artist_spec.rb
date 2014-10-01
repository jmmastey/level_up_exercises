require 'spec_helper'

describe Artist do
  subject(:artist) { Artist.new(name: "Beyonce") }

  it { should respond_to(:name) }

  it { should be_valid }

  describe "when name is not present" do
    before { artist.name = " " }
    it { should_not be_valid }
  end
end
