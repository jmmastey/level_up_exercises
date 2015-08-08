class ProfileController < ApplicationController
  before_action :authenticate_user!

  def index
    @library = current_user.library_items
  end

  def view
  end

  def add_anime
  end
end
