module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def log_out
    return if !logged_in?
    session.delete(:user_id)
    @current_user = nil
    @current_profile = nil
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def current_user?(user)
    user == current_user
  end

  def current_profile
    @current_profile ||= Profile.find_by(user_id: session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end
end
