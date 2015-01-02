def create_and_sign_in_admin
  @admin_user = create(:user, admin: true)
  sign_in @admin_user
end

def create_and_sign_in_user
  @user = create(:user)
  sign_in @user
end

def sign_in_user(user)
  sign_in user
end
