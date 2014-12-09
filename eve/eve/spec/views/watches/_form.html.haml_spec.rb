require "rails_helper"

describe "watches/_form", type: :view do
  before(:each) { assign(:watch, watch) }

  context "when creating a new watch" do
    let(:watch) { Watch.new }

    it "has a nickname field" do
      render
      expect(rendered).to have_css("input#watch_nickname")
    end

    it "has a item ID field" do
      render
      expect(rendered).to have_css("input#watch_item_id")
    end

    it "has a region ID field" do
      render
      expect(rendered).to have_css("input#watch_region_id")
    end

    it "has a station ID field" do
      render
      expect(rendered).to have_css("input#watch_station_id")
    end
  end

  context "when editing an existing watch" do
    let(:item) { FactoryGirl.create(:item) }
    let(:region) { nil }
    let(:station) { nil }

    let(:watch) do
      FactoryGirl.create(:watch,
                         nickname: "Test",
                         item: item,
                         region: region,
                         station: station)
    end

    it "populates the form with the existing nickname" do
      render
      css = "input#watch_nickname[value='#{watch.nickname}']"
      expect(rendered).to have_css(css)
    end

    it "populates the form with the existing item ID" do
      render
      css = "input#watch_item_id[value='#{watch.item_id}']"
      expect(rendered).to have_css(css)
    end

    context "when filtering by region" do
      let(:region) { FactoryGirl.create(:region) }

      it "populates the form with the existing region ID" do
        render
        css = "input#watch_region_id[value='#{watch.region_id}']"
        expect(rendered).to have_css(css)
      end
    end

    context "when filtering by station" do
      let(:station) { FactoryGirl.create(:station) }
      it "populates the form with the existing station ID" do
        render
        css = "input#watch_station_id[value='#{watch.station_id}']"
        expect(rendered).to have_css(css)
      end
    end
  end
end
