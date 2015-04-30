When(/^I click on a movie poster$/) do	
  find('img.thumbnails').click
end

Then(/^I am redirected to movie page$/) do
  visit("https://be-a-critique.herokuapp.com/movies/#{@movie.id}")
end

Then(/^I see movie title$/) do
  expect(page).to have_content("Title: #{@movie.name}")
end

Then(/^I see movie release date$/) do
  expect(page).to have_content("Release Date: #{@movie.release_date}")
end

Then(/^I see no reviews posted$/) do
  expect(page). to have_content('No reviews just yet')
end

Then(/^I see a link to write a review$/) do
  expect(page). to have_link('Write a Review')
end

Then(/^I see prevously posted reviews$/) do
  FactoryGirl.create(:review, movie_id: @movie.id)
  @review = Review.first
  visit("https://be-a-critique.herokuapp.com/movies/#{@movie.id}")
  expect(page).to have_content("#{@review.comment}")
end
