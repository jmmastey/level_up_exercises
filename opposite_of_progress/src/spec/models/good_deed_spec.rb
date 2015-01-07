require 'rails_helper'

RSpec.describe GoodDeed, :type => :model do
  subject { FactoryGirl.build(:good_deed) }

  it { is_expected.to validate_presence_of :action }
  it { is_expected.to validate_presence_of :acted_at }
  it { is_expected.to validate_presence_of :bill_id }
  it { is_expected.to belong_to :bill }
  it { is_expected.to belong_to :legislator }
end
