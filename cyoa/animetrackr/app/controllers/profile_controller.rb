class ProfileController < ApplicationController
  before_action :authenticate_user!

  def index
    @library = current_user.library_items
    @activities = sort_by_created_date_desc(current_user.activities)
    @pending = FriendRequest.get_pending(current_user)
    @requests = FriendRequest.get_requests(current_user)
    @friends = Friend.get_friends(current_user)
  end

  def view
    @user = User.find_by(username: params[:username])
    @activities = sort_by_created_date_desc(@user.activities)
    @friends = Friend.get_friends(@user)
    @library = @user.library_items
  end

  private

  def sort_by_created_date_desc(items)
    items.sort { |a, b| b.created_at <=> a.created_at }
  end
end
