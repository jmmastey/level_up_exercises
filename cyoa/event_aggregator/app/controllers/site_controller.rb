class SiteController < ApplicationController
  skip_before_action :authenticate_user!

  def about_us
    # Just render the view
  end
end
