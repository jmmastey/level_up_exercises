require 'rails_helper'

RSpec.describe Review, :type => :model do
  it { should validate_presence_of :user }
  it { should validate_presence_of :performance }
  it { should validate_presence_of :rating }
  it { should validate_numericality_of :rating }
  it { should_not validate_presence_of :review }

  describe ".recent_ratings" do
    let(:performance) { FactoryGirl.create(:performance) }
    subject(:recent_rating) { Review.recent_ratings(performance) }

    it "returns the average rating for performances" do
      FactoryGirl.create_list(:review, 10, rating: 5, performance: performance)
      FactoryGirl.create_list(:review, 10, rating: 3, performance: performance)

      expect(recent_rating).to eq(4)
    end

    it "only shows recent reviews" do
      FactoryGirl.create(:review, rating: 1, performance: performance, created_at: 1.year.ago)
      FactoryGirl.create_list(:review, 10, rating: 4, performance: performance)
      FactoryGirl.create_list(:review, 10, rating: 3, performance: performance)

      expect(recent_rating).to eq(3.5)
    end
  end

  describe "#sentiment" do
    let(:performance) { FactoryGirl.create(:performance) }
    before(:each) do
      10.times { build_review(3).save! }
      10.times { build_review(4).save! }
    end

    def build_review(rating)
      FactoryGirl.build(:review, rating: rating,
        performance: performance, created_at: 1.day.ago
      )
    end

    it "knows I'm a pretty meh review in real life" do
      review = build_review(3)
      expect(review.sentiment).to be(:meh)

      review = build_review(4)
      expect(review.sentiment).to be(:meh)
    end

    it "tracks chipper people accurately" do
      review = build_review(5)
      expect(review.sentiment).to be(:happy)
    end

    it "tracks morose people accurately" do
      review = build_review(2)
      expect(review.sentiment).to be(:sad)
    end
  end
end
