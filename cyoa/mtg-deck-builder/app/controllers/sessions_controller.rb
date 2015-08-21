class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:session][:username].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to user
    else
      flash.now[:error] = 'Invalid username or password.'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
