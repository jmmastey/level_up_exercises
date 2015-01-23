require 'rails_helper'

RSpec.describe UserContact, :type => :model do
  describe "user_id" do
    it { should_not accept_values_for(:user_id, nil) }
  end

  describe "contact_type_id" do
    it { should_not accept_values_for(:contact_type_id, nil) }
  end
  
  describe "contact" do
    it { should_not accept_values_for(:contact, nil, "") }
    it "must have valid format for email" do
      subject.user_id = 1
      subject.contact_type_id = ContactType.find(name: "email")
      subject.contact.should_not accept_values_for(:email, "jeremyatfinzel", "jeremy@@finzel", "jeremy@finzel", "jeremy@finzel.net") }
    end
  end
end
