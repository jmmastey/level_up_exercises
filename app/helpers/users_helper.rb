module UsersHelper

  def current_user?
    current_user == @user
  end

  def account_type
    if @user.admin?
      "Administrator"
    else
      "Basic"
    end
  end
end
