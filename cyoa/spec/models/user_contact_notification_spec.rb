require 'rails_helper'

RSpec.describe UserContactNotification, :type => :model do
  describe "user_contact_id" do
    it { should_not accept_values_for(:user_contact_id, nil) }
  end

  describe "start_time" do
    it { should_not accept_values_for(:start_time, nil) }
    it { should accept_values_for(:start_time, "2015-01-01 06:00:00") }
  end

  describe "interval_minutes" do
    it { should_not accept_values_for(:interval_minutes, nil, 1) }
    it { should accept_values_for(:interval_minutes, 3600) }
  end

  describe "end_time" do
    it { should accept_values_for(:end_time, nil) }

    it "should be later than the start time" do
      subject.start_time = "2015-01-01 06:00:00"
      subject.end_time.should_not accept_values_for(:end_time, "2015-01-01 04:00:00")
    end
  end
end
