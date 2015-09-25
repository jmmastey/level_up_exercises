require 'rails_helper'

RSpec.describe OwnedActivity, type: :model do
  let(:activity) { FactoryGirl.create(:activity) }

  describe "#showable?" do
    context "when the hidden attribute is true" do
      let(:owned) { FactoryGirl.create(:owned_activity, hidden: true) }

      it { expect(owned.showable?).to be false }
    end
      
    context "when the hidden attribute is false" do
      let(:owned) { FactoryGirl.create(:owned_activity, hidden: false) }

      it { expect(owned.showable?).to be true }
    end
  end

  describe "#goal?" do
    context "when the index attribute is nil" do
      let(:owned) { FactoryGirl.create(:owned_activity, index: nil) }

      it { expect(owned.goal?).to be false }
    end
      
    context "when the index attribute is not nil" do
      let(:owned) { FactoryGirl.create(:owned_activity, index: "3") }

      it { expect(owned.goal?).to be true }
    end
  end
  
  describe "#hide" do
    let(:owned) { FactoryGirl.create(:owned_activity, hidden: false) }

    it "sets hidden to true" do
      owned.hide

      expect(OwnedActivity.first.hidden).to be true
    end
  end
  
  describe "#unhide" do
    let(:owned) { FactoryGirl.create(:owned_activity, hidden: true) }

    it "sets hidden to false" do
      owned.unhide

      expect(OwnedActivity.first.hidden).to be false
    end
  end
end
