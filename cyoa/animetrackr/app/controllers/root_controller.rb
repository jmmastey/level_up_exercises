class RootController < ApplicationController
  def home
    redirect_to '/profile' if user_signed_in?
  end

  def signup
  end
end
