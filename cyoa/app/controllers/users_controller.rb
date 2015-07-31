class UsersController < ApplicationController
  def show
    @user = User.find_by_id(params["id"])
    @ebooks = @user.ebooks.order('lower(title)') if @user
  end
end
