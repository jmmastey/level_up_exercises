require 'spec_helper'

RSpec.describe GoodDeedsMailer do
  before(:each) do
    ActionMailer::Base.delivery_method = :test
    ActionMailer::Base.perform_deliveries = true
    ActionMailer::Base.deliveries = []
  end

  describe "#new_deed_notification" do
    it "adds legislator to user favorites" do
      expect { FactoryGirl.create(:good_deed) }.
        to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end
end
