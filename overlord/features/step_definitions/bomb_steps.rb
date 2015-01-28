
Given(/^"(.*?)" says "(.*?)"$/) do |selector_id, status_text|
  selector_id.should have_content(status_text)
end


Given(/^a bomb is "(.*?)"$/) do |arg1|
  Bomb.destroy_all
  @bomb = Bomb.create(activation_code: "12345",
                          deactivation_code: "0000",
                          detonation_time: 45,
                          status: arg1)

end


Given(/^I am looking at the page bomb$/) do
  visit "/"
  visit "/bomb/#{@bomb.id}"
end

Given(/^I am looking at the page "(.*?)"$/) do |arg1|
  visit "/"
  visit "/bomb/#{@bomb.id}"
end

When(/^I enter right "(.*?)"$/) do |arg1|

  url = status[arg1]["url"]

  visit "/"
  visit "/#{url}"
  find(:css,"#"+"#{arg1}").set(@bomb[arg1])
  click_button status[arg1]["button"]

end

When(/^I enter wrong "(.*?)"$/) do |arg1|
  status = {}
  status["activation_code"] = {}
  status["deactivation_code"] = {}
  status["activation_code"]["url"]="bomb_activate"
  status["activation_code"]["button"]="Activate"

  status["deactivation_code"]["url"]="bomb_deactivate"
  status["deactivation_code"]["button"]="Deactivate"

  url = status[arg1]["url"]

  visit "/"
  visit "/#{url}"
  find(:css,"#"+"#{arg1}").set(@bomb[arg1]+@bomb[arg1].reverse)
  click_button status[arg1]["button"]
end

Then(/^"(.*?)" should contain "(.*?)"$/) do |arg1, arg2|
 pending
end

Then(/^the bomb status is "(.*?)"$/) do |arg1|
  expect(find(:css, "#bomb_status").text).to eq(arg1.downcase)
end

Then(/^bomb should be "(.*?)"$/) do |arg1|
  expect(find(:css, "#bomb_status").text).to eq(arg1)
end
