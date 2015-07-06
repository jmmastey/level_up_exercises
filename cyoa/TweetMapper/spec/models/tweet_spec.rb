require 'rails_helper'

RSpec.describe Tweet, type: :model do
  it 'has a valid factory' do
    tweet = create(:tweet)
    expect(tweet).to be_valid
  end
  it 'is invalid without a tweet_id' do
    tweet = build(:tweet, tweet_id_from_twitter: nil)
    expect(tweet).not_to be_valid
  end
  it 'is invalid without a unique tweet_id_from_twitter' do
    tweet_id = Faker::Number.number(18)
    tweet1 = create(:tweet, tweet_id_from_twitter: tweet_id)
    tweet2 = build(:tweet, tweet_id_from_twitter: tweet_id)
    expect(tweet1).to be_valid
    expect(tweet2).not_to be_valid
  end
  it 'is invalid without an author_screen_name' do
    tweet = build(:tweet, author_screen_name: nil)
    expect(tweet).not_to be_valid
  end
  it 'is invalid without an author_name' do
    tweet = build(:tweet, author_name: nil)
    expect(tweet).not_to be_valid
  end
  it 'is invalid without a latitude' do
    tweet = build(:tweet, latitude: nil)
    expect(tweet).not_to be_valid
  end
  it 'is invalid without a longitude' do
    tweet = build(:tweet, longitude: nil)
    expect(tweet).not_to be_valid
  end
  it 'is invalid without a tweet_created_at' do
    tweet = build(:tweet, tweet_created_at: nil)
    expect(tweet).not_to be_valid
  end
end
