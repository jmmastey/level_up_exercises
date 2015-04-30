VALID_COMMENT = "great movie!"
EMPTY_COMMENT = ""
When(/^I click Write a Review link$/) do
  click_link('Write a Review', match: :first)
end

Then(/^I see review page$/) do
  expect(page).to have_field('review_comment')
end

Given(/^I am on review page$/) do
  visit("https://be-a-critique.herokuapp.com/movies/#{@movie.id}/reviews/new")
end

When(/^I give a rating$/) do
	expect(page).to have_css("#star-rating")
end

When(/^I enter valid comment$/) do
  fill_in('review_comment', with: VALID_COMMENT)
end

When(/^I click 'Create Review' button$/) do
  click_button('Create Review')
  FactoryGirl.create(:review, rating: 3, comment: VALID_COMMENT, movie_id: @movie.id)
end

Then(/^I see my comment on movie page$/) do
	expect(page).to have_content(VALID_COMMENT)
end

When(/^I do not enter anything in the comment field$/) do
  fill_in('review_comment', with: EMPTY_COMMENT)
end

Then(/^I see error message for empty comment$/) do
  expect(page).to have_content('Comment cannot be empty')
end

Then(/^I stay on the same page$/) do
  expect(page).to have_field('review_comment')
end