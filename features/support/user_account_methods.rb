def sign_up_user
  visit root_path
  click_link("Sign up")
  fill_in("First Name", with: "Paul")
  fill_in("Last Name", with: "Haddad")
  fill_in("Email", with: "user@example.com")
  fill_in("Password", with: "password")
  fill_in("Password confirmation", with: "password")
  click_button("Sign up")
end
