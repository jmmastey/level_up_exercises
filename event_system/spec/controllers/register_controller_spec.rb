require 'spec_helper'
require 'rspec/rails'

describe RegisterController, type: :controller do

  describe "index" do
  end

  describe "create" do
    before do
      EmailContact.destroy_all
    end
    it "should store emails along with region when customer registers" do
      post :create, email: "johndoe@example.com", region: "Chicago"
      email_contact = EmailContact.last
      region_id  = Region.region_id("Chicago").pluck("region_id").first
      expect(email_contact.region_id).to eq(region_id)
      expect(email_contact.email).to eq("johndoe@example.com")
    end
  end
end
