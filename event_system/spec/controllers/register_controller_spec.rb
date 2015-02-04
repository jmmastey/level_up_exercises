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
      expect(EmailContact.count).to eq(1)
    end
  end
end
