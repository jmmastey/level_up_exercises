require 'spec_helper'
require_relative 'user_helper'

describe User do

  let(:valid_user) { create_user('Kevin Kline', 'coolguy@besthost.com') }
  let(:find_valid) { User.find_by(email: 'coolguy@besthost.com') }
  let(:upcase_email_user) { create_user('Lee Majors', 'LMAJORS@BESTHOST.COM') }

  let(:duplicate_email_user) { create_user('John Ritter', 'COOLGuy@BestHost.com') }
  let(:blank_name_user) { create_user('', 'blank@besthost.com') }
  let(:blank_email_user) { create_user('Blank Email', '') }
  let(:long_name_user) { create_user('qwerty' * 10, 'lname@besthost.com') }
  let(:bad_email_user) { create_user('Bad Email', 'junk.junk.com') }

  let(:blank_password_user) { create_user('Bad Password', 'bpass@besthost.com', '', '') }
  let(:short_password_user) { create_user('Bad Password', 'bpass@besthost.com', 'short', 'short') }
  let(:mismatch_password_user) { create_user('Mismatch Password', 'mpass@besthost.com', 'pass-me', 'fail-me') }

  it 'responds to name' do
    expect(valid_user).to respond_to(:name)
  end

  it 'responds to email' do
    expect(valid_user).to respond_to(:email)
  end

  it 'responds to password_digest' do
    expect(valid_user).to respond_to(:password_digest)
  end

  it 'responds to password' do
    expect(valid_user).to respond_to(:password)
  end

  it 'responds to password_confirmation' do
    expect(valid_user).to respond_to(:password_confirmation)
  end

  it 'responds to remember_token' do
    expect(valid_user).to respond_to(:remember_token)
  end

  it 'responds to authenticate' do
    expect(valid_user).to respond_to(:authenticate)
  end

  it 'is valid when proper name supplied' do
    expect(valid_user).to be_valid
  end

  it 'is stored with lowercase e-mail' do
    expect(User.find(upcase_email_user[:id]).email).to eq('lmajors@besthost.com')
  end

  it 'has a non-empty remember_token' do
    expect(valid_user.remember_token).not_to be_blank
  end

  it 'will not create a user with an email that already exists' do
    valid_user
    expect(duplicate_email_user).to be_invalid
  end

  it 'is invalid when blank name supplied' do
    expect(blank_name_user).to be_invalid
  end

  it 'is invalid when blank email supplied' do
    expect(blank_email_user).to be_invalid
  end

  it 'is invalid when name is too long' do
    expect(long_name_user).to be_invalid
  end

  it 'is invalid when email is bad-format' do
    expect(bad_email_user).to be_invalid
  end

  it 'is invalid when password is blank' do
    expect(blank_password_user).to be_invalid
  end

  it 'is invalid when password does not match confirmation is blank' do
    expect(mismatch_password_user).to be_invalid
  end

  it 'is invalid when password is too short' do
    expect(short_password_user).to be_invalid
  end

  it 'authenticates a valid password' do
    valid_user
    expect(find_valid.authenticate('pass-me')).to eq(valid_user)
  end

  it 'does not authenticate an invalid password' do
    valid_user
    expect(find_valid.authenticate('fail-me')).to be false
  end
end
