require 'rails_helper'

RSpec.describe UserNotification, :type => :model do
  describe "user_id" do
    it { should_not accept_values_for(:user_id, nil) }
  end

  describe "notification_time" do
    it { should_not accept_values_for(:notification_time, nil) }
    it { should accept_values_for(:notification_time, "06:00:00") }
  end

  describe "active" do
    it { should accept_values_for(:active, true, false) }
    it { should_not accept_values_for(:active, 22, "abcd") }
    it "should have a default of false and not nil" do
      pending #FactoryGirl.create (:user)
    end
  end
end
