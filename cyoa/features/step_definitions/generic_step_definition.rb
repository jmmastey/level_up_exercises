When /^the user clicks (.*)$/ do |text|
  find_link(text).click
end

When /^the user presses (.*)$/ do |text|
  find_button(text).click
end

Given /^the user is on the (.*) page$/ do |goal|
  case goal
  when "home"
    visit home_path
  when "Edit Account"
    visit edit_user_registration_path
  when "library"
    visit ebooks_path
  end
end

Then /^the user should be on the (.*) page$/ do |goal|
  case goal
  when "Edit Account"
    sleep(0.1)
    expect(page.current_path).to eq(edit_user_registration_path)
  when "Sign Up"
    expect(page.current_path).to eq(new_user_registration_path)
  when "ebook's"
    expect(page.html).to have_content('Source URL')
    expect(page.html).to have_content('Download Epub')
  when "login"
    sleep(0.1)
    expect(find('.jumbotron').text).to eq("Log In")
  end
end

Then /^the user should be on their profile page$/ do
  sleep(0.1)
  expect(page.html).to have_content('Biography')
  # Edit button
  expect(find('.btn-success').text).to have_content('Edit')
end
