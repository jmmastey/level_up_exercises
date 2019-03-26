require 'rails_helper'

RSpec.describe Performance, :type => :model do
  it { should validate_presence_of :performed_on }
  it { should validate_presence_of :show }
  it { should have_many :reviews }
  it { should belong_to :show }

  describe "#average_rating" do
    subject(:performance) { FactoryBot.create(:performance) }

    it "should return nil when there are no reviews" do
      expect(performance.average_rating).to be_nil
    end

    it "should provide the score when there is a single review" do
      FactoryBot.create(:review, rating: 4, performance: subject)
      expect(performance.average_rating).to eq(4)
    end

    it "should summarize all scores when they are available" do
      FactoryBot.create_list(:review, 30, rating: 5, performance: subject)
      FactoryBot.create_list(:review, 30, rating: 3, performance: subject)
      expect(performance.average_rating).to eq(4)
    end
  end
end
