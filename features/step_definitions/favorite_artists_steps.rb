Given(/^I have favorited (\d+) artists$/) do |arg1|
  artist_1 = create(:artist, first_name: "Claude",  last_name: "Monet")
  artist_2 = create(:artist, first_name: "Edouard", last_name: "Manet")
  user = create(:user, email: "user@example.com", password: "secret" )
  user.favorite_artists << artist_1
  user.favorite_artists << artist_2
  visit new_user_session_path
  fill_in("Email", with: "user@example.com")
  fill_in("Password", with: "secret")
  click_button("Log in")
end

Then(/^I should see my favorite artists on my user page$/) do
  expect(page).to have_content("Claude Monet")
  expect(page).to have_content("Edouard Manet")
end
