class WelcomeController < ApplicationController
  def index
    redirect_to events_path if signed_in?
  end
end
