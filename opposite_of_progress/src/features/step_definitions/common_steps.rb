# Whens
When /I click (.+) link/ do |link|
  click_link(link)
end

# Thens
Then /I see (.+) link/ do |link|
  expect(page).to have_link(link)
end

Then /I am on (.+) page/ do |page|
  path = case page
  when 'home'
    '/'
  when 'legislators'
    '/legislators'
  when 'good deeds'
    '/good_deeds'
  when 'bills'
    '/bills'
  when '/search'
    'search'
  end

  visit path
end
