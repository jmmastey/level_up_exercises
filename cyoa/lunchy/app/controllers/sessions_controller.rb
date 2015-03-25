class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to user
    else
      flash.now[:danger] = "Invalid email and/or password"
      @hide_login_fields = true
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
