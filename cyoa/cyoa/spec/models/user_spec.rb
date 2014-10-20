require 'spec_helper'

describe User do
  subject(:user) { FactoryGirl.create(:user) }

  it { is_expected.to be_valid }

  it { is_expected.to respond_to(:artists) }
end
