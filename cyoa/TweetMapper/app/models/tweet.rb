require 'upsert/active_record_upsert'

class Tweet < ActiveRecord::Base
  acts_as_mappable lat_column_name: :latitude, lng_column_name: :longitude

  validates :tweet_id_from_twitter, presence: true, numericality: true
  validates :tweet_id_from_twitter, presence: true, uniqueness: true
  validates_presence_of :author_screen_name
  validates_presence_of :author_name
  validates_presence_of :tweet_text
  validates :latitude, presence: true, latitude: true
  validates :longitude, presence: true, longitude: true
  validates :tweet_created_at, presence: true, timeliness: true

  class << self
    include CustomSelect
    def harvest_from_twitter
      initialize_twitter_client
      UserSession.where('last_activity >= ?', buffer_window.seconds.ago).find_each do |user_session|
        query_for_tweets(user_session).collect { |tweet| upsert_tweet(tweet) }
      end
    end

    private

    def initialize_twitter_client
      @client = Twitter::REST::Client.new do |config|
        config.consumer_key = "BZAbS3emPSOQjXUAJM31q6nRk"
        config.consumer_secret = "iMhoWfMBk5UEQnE0ESYVtpfk4drji5gXLbGydqzGuXVe3xjzHA"
        config.access_token = "14140512-IbqG6CzfvVbRxvDp845B1wLOnJ4mIEBkNpXxpySx5"
        config.access_token_secret = "Zq6uawBJ4aXImXzZTcWPdoAlUopTi9W6x108Xi7YCQ1i5"
      end
    end

    def buffer_window
      Rails.configuration.seconds_between_screen_refreshes + Rails.configuration.seconds_api_buffer
    end

    def query_for_tweets(user_session)
      @client.search('',
        geocode: "#{user_session.latitude},#{user_session.longitude},#{user_session.miles_radius}mi",
      ).take(Rails.configuration.tweets_to_take)
    end

    def upsert_tweet(tweet)
      return unless tweet.geo?
      Tweet.upsert({ tweet_id_from_twitter: tweet.id },
        author_screen_name: tweet.user.screen_name,
        author_name: tweet.user.name,
        latitude: tweet.geo.lat,
        longitude: tweet.geo.lng,
        favorite_count: tweet.favorite_count,
        retweet_count: tweet.retweet_count,
        tweet_created_at: tweet.created_at.dup,
        tweet_text: tweet.text,
        created_at: Time.now,
        updated_at: Time.now)
    end
  end
end
