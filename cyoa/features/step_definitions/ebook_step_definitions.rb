Given /^there is a user with (.*) ebooks?$/ do |number|
  id = User.maximum(:id).to_i.next
  email = "user_#{id}@mail.com"
  u = create(:user, email: email)
  number.to_i.times { create(:ebook, user: u) }
end

Given /^there is a logged in user on (.*) with (.*) ebooks?$/ do |page, number|
  u = create(:user)
  number.to_i.times { create(:ebook, user: u) }
  visit home_path
  click_link "Sign In"
  fill_in "user_email", with: u.email
  fill_in "user_password", with: u.password
  click_button "Log In"
  case page
  when "the homepage"
    visit home_path
  when "their profile page"
    visit user_profile_path(u)
  when "the edit book page"
    visit edit_ebook_path(u.ebooks.first)
  when "the My Books page"
    visit my_ebooks_path
  when "the library page"
    visit ebooks_path
  when "the new ebook page"
    visit new_ebook_path
  else
    raise "Oops, not supported"
  end
end

When /^the user opens an ebook$/ do
  page.first('.thumbnail').click
end

When /^the user opens the author profile$/ do
  click_link("author_link")
end

When /^the user changes the book's title$/ do
  fill_in "ebook_title", with: "NEW TITLE"
end

When /^the user deletes the first ebook$/ do
  first('.fa-trash').click
  page.driver.browser.switch_to.alert.accept
end

When /^the user fills out the new ebook form$/ do
  ebook = build(:ebook)
  fill_in "ebook_title", with: ebook.title
  fill_in "ebook_description", with: ebook.description
  fill_in "ebook_version", with: ebook.version
  fill_in "ebook_url", with: ebook.url
  fill_in "ebook_language", with: ebook.language
  fill_in "ebook_publisher", with: ebook.publisher
  fill_in "ebook_subject", with: ebook.subject
  fill_in "ebook_rights", with: ebook.rights
  if ebook.readability
    check "ebook_readability"
  else
    uncheck "ebook_readability"
  end
end

Then /^the user should see exactly (.*) ebooks?$/ do |number|
  expect(page).to have_selector('.thumbnail', count: number.to_i)
end

Then /^the user should see less than (.*) ebooks?$/ do |number|
  expect(all(".thumbnail").size).to be < number.to_i
end

Then /^the ebook should be successfully updated$/ do
  expect(page.html).to have_content("Ebook was successfully updated.")
end

Then /^the ebook should be successfully destroyed$/ do
  expect(page.html).to have_content("Ebook was successfully destroyed.")
end

Then /^the user will have created an ebook$/ do
  expect(page.html).to have_content("Ebook was successfully created.")
end
