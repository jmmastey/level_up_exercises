require 'spec_helper'

describe User do

  let(:valid_user) { User.create(name: "Kevin Kline", email: "coolguy@besthost.com") }
  let(:duplicate_email_user) { User.create(name: "John Ritter", email: "COOLGuy@BestHost.com") }
  let(:upcase_email_user) { User.create(name: "Lee Majors", email: "LMAJORS@BESTHOST.COM") }

  let(:blank_name_user) { User.create(name: "", email: "blank@besthost.com") }
  let(:blank_email_user) { User.create(name: "Blank Email", email: "") }
  let(:long_name_user) { User.create(name: "qwerty" * 10, email: "lname@besthost.com") }
  let(:bad_email_user) { User.create(name: "Bad Email", email: "junk.junk.com") }

  it "responds to name" do
    expect(valid_user).to respond_to(:name)
  end

  it "responds to email" do
    expect(valid_user).to respond_to(:email)
  end

  it "is valid when proper name supplied" do
    expect(valid_user).to be_valid
  end

  it "is stored with lowercase e-mail" do
    expect(User.find(upcase_email_user[:id]).email).to eq("lmajors@besthost.com")
  end

  it "will not create a user with an email that already exists" do
    valid_user
    expect(duplicate_email_user).to be_invalid
  end

  it "is invalid when blank name supplied" do
    expect(blank_name_user).to be_invalid
  end

  it "is invalid when blank email supplied" do
    expect(blank_email_user).to be_invalid
  end

  it "is invalid when name is too long" do
    expect(long_name_user).to be_invalid
  end

  it "is invalid when email is bad-format" do
    expect(bad_email_user).to be_invalid
  end

end
