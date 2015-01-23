require 'rails_helper'

RSpec.describe ContactType, :type => :model do
  describe "name" do
    it { should_not accept_values_for(:name, nil, "") }
  end

  describe "type" do
    it { should_not accept_values_for(:type, nil, "") }
  end
end
