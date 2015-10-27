class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  protected

  def authenticate_user!
    redirect_to delivery_auth_authorize_path unless session[:user_id]
  end
end
