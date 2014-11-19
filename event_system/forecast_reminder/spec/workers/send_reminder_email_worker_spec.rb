require 'rails_helper'

describe SendReminderEmailWorker, type: :worker do
  let(:deliveries) { ActionMailer::Base.deliveries }
  subject { SendReminderEmailWorker.new }
  context "No users registered" do

    it "should not send any email" do
      expect { subject.perform }.to_not change(deliveries, :count)
    end
  end

  context "User not registered for daily forecast email" do
    let!(:user) { create(:user) }

    it "should not send any email" do
      expect { subject.perform }.to_not change(deliveries, :count)
    end
  end

  context "User registered for daily forecast email" do
    let!(:user) { create(:user, send_reminder: true) }
    let(:last_email) { deliveries.last }

    it "should not send any email" do
      expect { subject.perform }.to change(deliveries, :count).by(1)
      expect(last_email.subject).to eq "Daily Forecast Update"
    end
  end
end
