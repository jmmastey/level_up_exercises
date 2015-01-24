
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

Given(/^"(.*?)" is not configured$/) do |arg1|
  Bomb.create(activation_code: "1234")
  visit "/bomb"+ "/" + @bomb.id.to_s
  %w(1 2 3 4).each do |num|
    find(:xpath, "//span[@class='"+num+"']").click
  end
end

Given(/^"(.*?)" is configured to "(.*?)"$/) do |arg1, arg2|
  visit "/bomb"+ "/" + @bomb.id.to_s
  arg2.each_char do |num|
    find(:xpath, "//span[@class='"+num+"']").click
  end
end

When(/^I enter right "(.*?)"$/) do |arg1|
  #visit "/bomb"+ "/" + @bomb.id.to_s
  require 'pry'
  %w(1 2 3 4 5).each do |num|
    find(:xpath, "//span[@class='"+num+"']").click
  end

  binding.pry
end

Then(/^"(.*?)" should contain "(.*?)"$/) do |arg1, arg2|
  #visit "/bomb"+ "/" + @bomb.id.to_s
  arg2.each_char do |num|
    find(:xpath, "//span[@class='"+num+"']").click
  end
end

Then(/^the bomb status is "(.*?)"$/) do |arg1|
  selector = page.find_by_id("bomb_status")
  expect(selector.text.downcase).to eq(arg1.downcase)
end
