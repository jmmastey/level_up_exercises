module SessionsHelper

  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, remember_token)
    @current_user = user
  end

  def sign_out
    return unless signed_in?
    new_remember_token = User.new_remember_token
    current_user.update_attribute(:remember_token, new_remember_token)
    cookies.delete(:remember_token)
    @current_user = nil
  end

  def signed_in?
    current_user.present?
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    remember_token = cookies[:remember_token]
    @current_user || User.find_by(remember_token: remember_token)
  end

  def first_name
    name = current_user.try(:name) || 'Someone'
    name.split(/\s+/)[0]
  end
end
