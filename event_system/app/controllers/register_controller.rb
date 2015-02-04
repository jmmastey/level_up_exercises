class RegisterController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
  end

  def create
    EmailContact.create(email: params["region"],
      region_id: Region.select("region_id").where(city: params["region"]))
    render :index
  end
end
