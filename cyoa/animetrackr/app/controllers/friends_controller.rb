class FriendsController < ApplicationController
  def search
    return unless params[:username]
    params[:username].gsub!('+', ' ')
    @users = User.find_public_users(params[:username], current_user.username)
  end

  def search_redirect
    redirect_to action: 'search', username: params[:username].gsub(/\s+/, '+')
  end

  def send_request
    friend = User.find(params[:id])
    FriendRequest.create(from: current_user, to: friend)
    redirect_to(profile_path)
  end

  def accept
    request = FriendRequest.find(params[:id])
    Friend.create(user: request.from, friend: request.to)
    Friend.create(user: request.to, friend: request.from)
    request.destroy
    redirect_to(profile_path)
  end

  def reject
    request = FriendRequest.find(params[:id])
    request.destroy

    redirect_to(profile_path)
  end
end
