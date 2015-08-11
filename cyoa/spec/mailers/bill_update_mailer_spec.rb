require 'rails_helper'

describe BillUpdateMailer, type: :mailer do
  describe 'update' do
    before do
      @user = build(:user)
      @bill = create(:bill)
      @bill_hash = { @bill.id => ['Bill passed the Senate'] }
      @mail = BillUpdateMailer.update(@user, @bill_hash)
    end

    it 'renders the subject' do
      expect(@mail.subject).to eql('Good Deeds Updates for your bookmarked bills')
    end

    it 'renders the receiver email' do
      expect(@mail.to).to eql([@user.email])
    end

    it 'renders the sender email' do
      expect(@mail.from).to eql(['noreply@gooddeeds.com'])
    end

    it 'assigns @bill' do
      expect(@mail.body.encoded).to match(@bill_hash[@bill.id][0])
    end
  end
end
