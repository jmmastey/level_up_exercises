
Given(/^"(.*?)" says "(.*?)"$/) do |selector_id, status_text|
  selector_id.should have_content(status_text)
end


Given(/^a bomb is "(.*?)"$/) do |arg1|
  @bomb = Bomb.create(activation_code: "12345",
                          deactivation_code: "0000",
                          detonation_time: 45,
                          status: arg1)

end


Given(/^I am looking at the page bomb$/) do
  visit "/"
  visit current_url + "/bomb/#{@bomb.id}"
end

When(/^I enter right "(.*?)"$/) do |arg1|
  %w(1 2 3 4 5).each do |num|
    find(:css, ".keypad-"+num).click
  end
end

Then(/^"(.*?)" should contain "(.*?)"$/) do |arg1, arg2|
  #visit "/bomb"+ "/" + @bomb.id.to_s
  arg2.each_char do |num|
    find(:css, ".keypad-"+num).click
  end
end

Then(/^the bomb status is "(.*?)"$/) do |arg1|
  selector = page.find_by_id("bomb_status")
  expect(selector.text.downcase).to eq(arg1.downcase)
end

Then(/^bomb should be "(.*?)"$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end
