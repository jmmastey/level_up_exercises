When(/^I activate the bomb with code (\d+)$/) do |code|
  fill_in('activation_code', with: code)
  find('.btn.activate-bomb').click
end

Then(/^the bomb should be activated$/) do
  expect(find('.bomb-state').text.downcase).to eq('activated')
end

When(/^I deactivate the bomb with code (\d+)$/) do |code|
  fill_in('deactivation_code', with: code)
  find('.btn.deactivate-bomb').click
end

Then(/^the bomb should be deactivated$/) do
  expect(find('.bomb-state').text.downcase).to eq('deactivated')
end