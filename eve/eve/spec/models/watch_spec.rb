require 'rails_helper'

RSpec.describe Watch, type: :model do
  context "when initialized with an item and order" do
    subject(:valid_watch) { FactoryGirl.build(:watch) }

    it { is_expected.to be_valid }
  end

  context "when initialized without an item" do
    subject(:invalid_watch) do
      FactoryGirl.build(:watch, item: nil)
    end

    it { is_expected.not_to be_valid }
  end

  context "when initialized without an user" do
    subject(:invalid_watch) do
      FactoryGirl.build(:watch, user: nil)
    end

    it { is_expected.not_to be_valid }
  end
end
