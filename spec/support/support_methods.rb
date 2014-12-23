def create_and_sign_in_user
  @user = create(:user)
  sign_in @user
end
