Given(/^the bomb is activated with code "(.*?)"$/) do |code|
  visit("/")
  fill_in("Code", with: code)
  click_button("Enter")
end
