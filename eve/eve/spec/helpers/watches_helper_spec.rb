require "rails_helper"

describe WatchesHelper do
  describe "#no_location_filter?" do
    subject(:no_location_filter?) { helper.no_location_filter?(watch) }

    context "when the watch has no location filter" do
      let(:watch) { FactoryGirl.create(:watch) }
    end

    context "when the watch has a region filter" do
      let(:region) { FactoryGirl.create(:region) }
      let(:watch) { FactoryGirl.create(:watch) }
    end

    context "when the watch has a station filter" do
      let(:watch) { FactoryGirl.create(:watch) }
    end
  end
end
