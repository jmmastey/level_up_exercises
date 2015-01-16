require 'rails_helper'

RSpec.describe Bill, :type => :model do
  let(:subject) { FactoryGirl.build(:bill) }
  it { is_expected.to validate_presence_of :bill_type }
  it { is_expected.to validate_presence_of :chamber }
  it { is_expected.to validate_presence_of :official_title }

  it do
    is_expected.to validate_inclusion_of(:chamber)
      .in_array(%w(senate house))
  end

  it { is_expected.to have_many :good_deeds}
  it { is_expected.to have_many :cosponsorships}
  it { is_expected.to have_many :sponsorships}
  it { is_expected.to have_many :actions}

  context '#official_id' do
    it 'displays official_id' do
      bill = FactoryGirl.build(:bill, congress: 113, bill_type: 'hres', number: '32')
      expect(bill.official_id).to eq('HRES32-113')
    end
  end
end
