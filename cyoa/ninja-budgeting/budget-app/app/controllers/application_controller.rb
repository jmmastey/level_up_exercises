class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  def home
    if logged_in?
      redirect_to '/dashboard'
    else
      render 'layouts/home'
    end
  end
end
