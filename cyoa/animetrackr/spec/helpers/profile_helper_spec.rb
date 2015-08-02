require 'rails_helper'
require 'digest'

RSpec.describe ProfileHelper, type: :helper do
  describe('#gravatar_for') do
    it 'should return a gravatar url for user email' do
      email = 'test@example.com'
      gravatar_url = 'https://www.gravatar.com/avatar/' +
                     Digest::MD5.hexdigest(email)

      expect(gravatar_for('test@example.com')).to eq(gravatar_url)
    end
  end

  describe('#member_since') do
    it 'should return the join date in a formatted date' do
      format_regex = /Member Since: \d{2}-\d{2}-\d{4}/
      expect(member_since(Time.now)).to match(format_regex)
    end
  end
end
