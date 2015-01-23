require 'rails_helper'

RSpec.describe User, :type => :model do
  subject(:user) { User.new }

  describe "validation" do
    it { should accept_values_for(:email, "jeremy@finzel.net") }
    it { should_not accept_values_for(:email, nil) }
    it { should_not accept_values_for(:email, "", "jeremyatfinzel", "jeremy@@finzel", "jeremy@finzel") }
    it { should accept_values_for(:phone, "535-402-3813") }
    it { should_not accept_values_for(:phone, nil) }
    it { should_not accept_values_for(:phone, "") }
  end
end
