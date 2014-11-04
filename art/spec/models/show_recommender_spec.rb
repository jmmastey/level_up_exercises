require 'rails_helper'

RSpec.describe ShowRecommender, :type => :model do
  let(:show_i_loved) { FactoryGirl.create(:show, :with_performances) }
  let(:show_i_should_see) { FactoryGirl.create(:show, :with_performances) }
  let(:me) { FactoryGirl.create(:user) }
  let(:stranger) { FactoryGirl.create(:user) }
  subject(:recommender) { ShowRecommender.new(me) }

  def create_awesome_review(user, show)
    FactoryGirl.create(:review, rating: 5, user: user,
                       performance: show.performances.last)
  end

  # set up other people's reviews
  before(:each) do
    create_awesome_review(stranger, show_i_loved)
    create_awesome_review(stranger, show_i_should_see)
  end

  describe "#recommendations" do
    it "returns an empty array if I have no reviews" do
      expect(subject.recommendations).to be_an(Array)
      expect(subject.recommendations).to be_empty
    end

    it "recommends shows based on what I love" do
      create_awesome_review(me, show_i_loved)
      expect(subject.recommendations).to eq([show_i_should_see])
    end

    it "provides a unique list" do
      other_stranger = FactoryGirl.create(:user)
      create_awesome_review(other_stranger, show_i_loved)
      create_awesome_review(other_stranger, show_i_should_see)

      create_awesome_review(me, show_i_loved)
      expect(subject.recommendations).to eq([show_i_should_see])
    end
  end
end
