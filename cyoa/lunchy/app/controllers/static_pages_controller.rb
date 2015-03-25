class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @user = current_user
      render "users/show" 
    else
      render "home"
    end
  end
end
