require 'rails_helper'

RSpec.describe User, :type => :model do
  let(:user) { FactoryGirl.build(:user) }
  let(:subject) { user }

    it { is_expected.to have_many(:favorite_legislators) }
    it { is_expected.to have_many(:legislators) }
end
