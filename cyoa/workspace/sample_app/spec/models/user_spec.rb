require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @new_user = User.create(name: "A Nother", email: "another@example.org")
  end


  describe "create a valid user" do
    it 'create a user', focus: true do
      user = User.create
      user.name = "JSON Vorhees"
      user.email = "me@gmail.com"
      #expect(@new_user.name).to eq("JSON Vorhees")
      expect(user).to be_valid
      #expect(@new_user).to be_valid
    end
  end

  describe "test invalid email addresses" do
    it "does not accept invalid emails", focus: true do
      invalid_addresses = %w[user@example.com me@gmail.com]
      #email invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com]
      invalid_addresses.each do |invalid_address|
        @new_user.name = invalid_address
        @new_user.email = invalid_address
        expect(@new_user).to be_valid
      end
    end
  end

  describe "duplicate names" do
    it "does not allow dupe names", focus: true do
      duplicate_user = @new_user.dup
      @new_user.save
      expect(duplicate_user).not_to be_valid
    end

    it "does not allow dupe names w capital letters", focus: true do
      duplicate_user = @new_user.dup
      duplicate_user.email = @new_user.email.upcase
      @new_user.save
      expect(duplicate_user).not_to be_valid
    end
  end
end