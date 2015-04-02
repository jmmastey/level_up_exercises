Given(/^a venue exists with a rating of (.*)$/) do |rating|
  create_venue(1, { rating: rating.to_f })
end

When(/^I get a recommendation with my minimum rating set to (.*)$/) do |rating|
  fill_in("profile_min_rating", with: rating.to_f) 
  click_button("profile_save") 
  click_button("get_rec_btn")
end

Given(/^I added it to my history yesterday$/) do
  venue = Venue.first
  user = User.first
  create_history({ venue_id: venue.id, user_id: user.id, visited: Date.yesterday })
end

When(/^I get a recommendation with my repeat interval set to (\d+)$/) do |interval|
  fill_in("profile_repeat_interval", with: interval)
  click_button("profile_save") 
  click_button("get_rec_btn")
end

Given(/^I added it to my blacklist$/) do
  venue = Venue.first
  user = User.first
  create_blacklist({ venue_id: venue.id, user_id: user.id })
end
