require 'rails_helper'

RSpec.describe Favorite, :type => :model do

  describe "associations" do

    it { should belong_to(:artist) }
    it { should belong_to(:user) }
  end
end
