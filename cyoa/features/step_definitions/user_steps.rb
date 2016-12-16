Given(/^I am a new user$/) do
  @user = create :user, password: 'password'
  fill_sign_in_form(@user.email, 'password')
end

Given(/^I visit the home page$/) do
  visit('/')
end

Given(/^there exists tags "(.*?)"$/) do |tag_names|
  tag_names.split(', ').each { |name| Tag.create(name: name) }
end

Given(/^I am a user with zipcode "(.*?)"$/) do |zipcode|
  @user = create :user, password: 'password', zipcode: zipcode
  fill_sign_in_form(@user.email, 'password')
end

Given(/^I am a new user with political party "(.*?)"$/) do |party|
  @user = create :user, password: 'password', political_party: party
  fill_sign_in_form(@user.email, 'password')
end

Given(/^I am a new user with tags "(.*?)"$/) do |tag_names|
  @user = create :user, password: 'password'
  fill_sign_in_form(@user.email, 'password')
  tag_names.split(', ').each do |tag_name|
    tag = create(:tag, name: tag_name)
    create(:user_tag, tag_id: tag.id, user_id: @user.id)
  end
end

Given(/^I visit the account page$/) do
  visit("/users/#{@user.id}")
end

When(/^I set "(.*?)" as "(.*?)"$/) do |field, value|
  fill_in(field, with: value)
end

When(/^I select political party "(.*?)"$/) do |party|
  select(party, from: "user_political_party")
end

When(/^I select "(.*?)"$/) do |tag_name|
  tag = Tag.where(name: tag_name).first
  find('#user_tag_tag_id', visible: false).set(tag.id)
end

When(/^I click "(.*?)"$/) do |text|
  expect(page).to have_content(text)
  click_on(text)
end

When(/^I remove "(.*?)"$/) do |tag_name|
  find("li", text: tag_name).find("a").click
end

Then(/^I see "(.*?)"$/) do |message|
  expect(page).to have_content(message)
end

Then(/^I have (\d+) tags$/) do |num|
  expect(page).to have_css('ul.tags')
  expect(@user.tags.count).to eq(num.to_i)
end
