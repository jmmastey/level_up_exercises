module SessionsHelper

  # logs in a given user
  def log_in(user)
    session[:user_id] = user.id
  end

  # log out current user
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  def forget(user)
    user.forget()
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # remembers a user in a persistent session
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # redirects to stored location (or to default)
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # stores the url trying to be accessed
  def store_location
    session[:forwarding_url] = request.url if request.get?
  end

  # returns the current logged-in user (if any)
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in(user)
        @current_user = user
      end
    end
  end

  # returns true if the given user is the current user
  def current_user?(user)
    user == current_user
  end

  # returns true if user is logged in
  def logged_in?
    !current_user.nil?
  end
end
