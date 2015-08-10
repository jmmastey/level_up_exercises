class ProfileController < ApplicationController
  before_action :authenticate_user!

  def index
    @library = current_user.library_items
    @activities = sort_by_created_date_desc(current_user.activities)
  end

  def view
  end

  def add_anime
  end

  private

  def sort_by_created_date_desc(items)
    items.sort { |a, b| b.created_at <=> a.created_at }
  end
end
