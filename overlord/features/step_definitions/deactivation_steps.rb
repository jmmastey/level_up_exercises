When(/^I enter code "(.*?)" "(.*?)" times$/) do |code, count|
  count.to_i.times do
    fill_in("Code", with: code)
    click_button("Enter")
  end
end
