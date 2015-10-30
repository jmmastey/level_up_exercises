class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  before_action :check_session_expiry

  def current_user
    @user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def authenticate_user!
    redirect_to new_session_path unless logged_in?
  end

  def delivery_client
    Delivery::Client.new(AppConfig.delivery.site,
      ENV["DELIVERY_API_KEY"],
      ENV["DELIVERY_API_SECRET"],
      delivery_auth_callback_url)
  end

  private

  def check_session_expiry
    return unless session[:user_id] || session_expired?

    session[:user_id] = nil
    session[:expires] = nil
  end

  def session_expired?
    session[:expires] && session[:expires] < Time.now.utc
  end
end
