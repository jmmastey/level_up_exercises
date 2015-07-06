class TweetsController < ApplicationController
  def latest
    session_errors = parse_session_errors(current_user_session)
    return json_response(session_errors) if session_errors.length > 0
    Tweet.harvest_from_twitter
    json_response(session_errors, retrieve_latest_tweets)
  rescue Twitter::Error::TooManyRequests
    json_response(['Twitter rate limit exceeded. Please speak with a site administrator or wait a minute and try again.']);
  end

  private

  def current_user_session
    user_session = UserSession.find_by(session_key: session.id)
    if user_session.nil?
      user_session = UserSession.create(user_session_params)
    else
      user_session.update(user_session_params)
    end
    user_session
  end

  def retrieve_latest_tweets(limit = 100)
    Tweet.select_without(:id, :created_at, :updated_at).within(
      params[:miles_radius],
      origin: [params[:center][:lat], params[:center][:lng]],
    ).order(tweet_created_at: :desc).limit(limit)
  end

  def parse_session_errors(user_session)
    errors = []
    if user_session.errors.messages.length > 0
      error = 'There was a problem updating your session. Please contact a site administrator.'
      error << user_session.errors.messages.inspect if Rails.env == 'development'
      errors << error
    end
    errors
  end

  def user_session_params
    {
      session_key: session.id,
      latitude: params[:center][:lat],
      longitude: params[:center][:lng],
      miles_radius: params[:miles_radius],
      last_activity: Time.now,
    }
  end
end
