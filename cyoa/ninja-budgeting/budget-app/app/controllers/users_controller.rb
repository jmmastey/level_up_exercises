class UsersController < ApplicationController
  before_action :logged_in_user

  def dashboard
    @funds = current_user.funds
  end

  private

  def logged_in_user
    return if logged_in?
    flash[:danger] = 'Please log in first.'
    redirect_to root_path
  end
end
