class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    user_path(@user)
  end

  def require_admin
    unless current_user_admin?
      flash[:alert] = "Only Adminstrators can search for new artists."
      redirect_to root_url
    end
  end

  def current_user_admin?
    current_user && current_user.admin?
  end

  helper_method :current_user_admin?
end
