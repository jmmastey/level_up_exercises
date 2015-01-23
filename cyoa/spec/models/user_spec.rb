require 'rails_helper'

RSpec.describe User, :type => :model do
  describe "email" do
    it should accept_values_for(:email, "jeremy@finzel.net") }
    it should_not accept_values_for(:email, nil, "", "jeremyatfinzel", "jeremy@@finzel", "jeremy@finzel") }
  end

  describe "phone" do
    it should accept_values_for(:phone, "535-402-3813") }
    it should_not accept_values_for(:phone, nil, "") }
  end
end
