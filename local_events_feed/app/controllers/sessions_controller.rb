class SessionsController < ApplicationController
  def new
    redirect_to current_user if signed_in?
  end

  def create
    if authenticate_user?(params)
      user = find_user(params)
      sign_in(user)
      redirect_to user
    else
      redirect_to new_session_path, :flash => { :failed_to_authenticate => true }
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end

  private

  def authenticate_user?(params)
    user = find_user(params)
    user && user.authenticate(params[:session][:password])
  end

  def find_user(params)
    User.find_by(email: params[:session][:email])
  end
end
