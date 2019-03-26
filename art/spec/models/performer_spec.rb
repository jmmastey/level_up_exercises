require 'rails_helper'

RSpec.describe Performer, :type => :model do
  it { should validate_presence_of :name }
  it { should validate_presence_of :description }
  it { should have_and_belong_to_many :shows }
  it { should have_many :performances }

  describe "#average_rating" do
    subject(:performer) { FactoryBot.create(:performer, :with_performances) }

    it "should return nil when there are no reviews" do
      expect(performer.average_rating).to be_nil
    end

    it "should grab reviews for their performances" do
      FactoryBot.create(:review, rating: 4, performance: subject.performances.first)
      expect(performer.average_rating).to eq(4)
    end

    it "should summarize all scores when they are available" do
      FactoryBot.create_list(:review, 30, rating: 5, performance: subject.performances.first)
      FactoryBot.create_list(:review, 30, rating: 3, performance: subject.performances.last)
      expect(performer.average_rating).to eq(4)
    end
  end
end
