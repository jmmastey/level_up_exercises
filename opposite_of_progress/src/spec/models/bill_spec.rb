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

  # it { is_expected.to belong_to :sponsor }
  # it { is_expected.to have_many :cosponsorships }
  # it { is_expected.to have_many :cosponsors }
end
