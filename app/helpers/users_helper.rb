module UsersHelper

  def current_user?
    current_user == @user
  end
end
