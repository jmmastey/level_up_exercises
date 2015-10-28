class SessionsController < ApplicationController
  before_action :logout_user, only: [:destroy]

  def new
    if logged_in?
      redirect_to root_path
    else
      redirect_to delivery_auth_authorize_path
    end
  end

  private

  def logout_user
    session[:user_id] = nil
  end
end
