def sign_up(username, email, password)
  visit(new_user_registration_path)
  fill_in(:user_username, with: username)
  fill_in(:user_email, with: email)
  fill_in(:user_password, with: password)
  fill_in(:user_password_confirmation, with: password)
  click_button('Sign Up')
end

def sign_in(email, password)
  visit(new_user_session_path)
  fill_in(:user_email, with: email)
  fill_in(:user_password, with: password)
  click_button('Sign In')
end