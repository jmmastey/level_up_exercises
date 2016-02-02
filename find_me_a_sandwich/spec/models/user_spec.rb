require "rails_helper"

describe User, type: :model do
  let(:user) { FactoryGirl.build(:user) }

  let(:valid_names) do
    ["Greg", "Harrison", "Dave", "Harrison-Lowe", "van Gogh", "O'Malley"]
  end

  let(:invalid_names) do
    ["Greg.", "H@rrison", "dave4"]
  end

  describe "#last_name" do
    it "can have alphabetic characters, apostrophes, dashes and spaces" do
      valid_names.each do |name|
        user.last_name = name
        expect(user).to be_valid
      end
    end

    it "cannot have numerals or special symbols" do
      invalid_names.each do |name|
        user.last_name = name
        expect(user).not_to be_valid
      end
    end
  end

  describe "#first_name" do
    it "can have alphabetic characters, apostrophes, dashes and spaces" do
      valid_names.each do |name|
        user.first_name = name
        expect(user).to be_valid
      end
    end

    it "cannot have numerals or special symbols" do
      invalid_names.each do |name|
        user.first_name = name
        expect(user).not_to be_valid
      end
    end
  end
end
