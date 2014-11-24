def feedback_form
  { Subject: 'Feedback',
    Message: 'This is my feedback suggestion' }
end
Given(/^I am on the feedback page$/) do
  visit('/feedback')
end

When(/^I submit a feedback form$/) do
  submit_form('Send feedback', feedback_form)
end

Then(/^I should see a feedback confirmation$/) do
  expect(page).to have_content('Your feedback has been sent')
end

Then(/^I should see sign in required$/) do
  expect(page).to have_content('Sorry! You must be logged in to submit feedback')
end
