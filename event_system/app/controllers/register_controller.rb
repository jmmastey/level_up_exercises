class RegisterController < ApplicationController
  def index
  end

  def create
    EmailContact.create(email: params["email"],
      region_id: Region.region_id("Chicago").pluck("region_id").first)
    render :index
  end
end
