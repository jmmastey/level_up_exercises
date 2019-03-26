require 'rails_helper'

RSpec.describe Show, :type => :model do
  it { should validate_presence_of :name }
  it { should validate_presence_of :description }
  it { should validate_presence_of :year }
  it { should validate_presence_of :location }
  it { should validate_presence_of :director }
  it { should validate_presence_of :theatre_company }
  it { should validate_presence_of :notes }

  it { should have_many :performances }
  it { should have_many :reviews }

  describe "#trending" do
    subject(:trending) { Show.trending }

    it "respects my limits" do
      FactoryBot.create_list(:review, 10)
      expect(Show.trending(8)).to have(8).items
    end

    it "has its own limits" do
      FactoryBot.create_list(:review, 10)
      expect(trending).to have(5).items
    end

    it "returns shows with recent reviews" do
      old_show = FactoryBot.create(:review, created_at: 1.month.ago).performance.show
      FactoryBot.create_list(:review, 10, created_at: 1.minute.ago)

      expect(trending.map(&:id)).not_to include(old_show.id)
    end

    it "only returns shows with reviews" do
      FactoryBot.create_list(:review, 10)
      new_show = FactoryBot.create(:show)

      expect(trending).not_to include(new_show)
    end
  end

  describe ".num_reviews" do
    subject(:show) { FactoryBot.create(:show, :with_performances) }
    let!(:reviews) { FactoryBot.create_list(:review, 20, performance: show.performances.last) }

    it "returns the total number of reviews" do
    end
  end
end
