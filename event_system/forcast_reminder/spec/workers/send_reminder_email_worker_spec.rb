require 'rails_helper'

describe SendReminderEmailWorker, type: :worker do
  subject { SendReminderEmailWorker.new }
  context "No users registered" do
    before { subject.perform }

    it "should not send any email" do
      expect(ActionMailer::Base.deliveries).to be_empty
    end
  end

  context "User not registered for daily forecast email" do
    let!(:user) { create(:user) }
    before { subject.perform }

    it "should not send any email" do
      expect(ActionMailer::Base.deliveries).to be_empty
    end
  end

  context "User registered for daily forecast email" do
    let!(:user) { create(:user, send_reminder: true) }
    let(:deliveries) { ActionMailer::Base.deliveries }
    let(:last_email) { deliveries.last }

    it "should not send any email" do
      expect { subject.perform }.to change(deliveries, :count).by(1)
      expect(last_email.subject).to eq "Daily Forecast Update"
    end
  end
end
