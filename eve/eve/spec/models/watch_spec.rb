require 'rails_helper'

RSpec.describe Watch, :type => :model do
  context "when initialized with an item and order" do
    subject(:valid_watch) { FactoryGirl.build(:watch) }

    it { is_expected.to be_valid }
  end
end
