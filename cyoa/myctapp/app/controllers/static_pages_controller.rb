class StaticPagesController < ApplicationController
  def home
    @cta_api = CTA.new
  end

  def help
  end

  def about
  end
end
