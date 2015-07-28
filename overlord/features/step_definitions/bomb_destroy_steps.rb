When(/^I fail at deactivating the bomb$/) do
  fill_in('deactivation_code', with: "fail")
  find('.btn.deactivate-bomb').click
  # Close sweet alerts
  find('.sweet-alert .confirm').click
  find('.btn.deactivate-bomb').click
  find('.sweet-alert .confirm').click
  find('.btn.deactivate-bomb').click
  find('.sweet-alert .confirm').click
end

When(/^I wait for (\d+) seconds$/) do |seconds|
  sleep(seconds.to_i)
end

Then(/^the world should be destroyed$/) do
  expect(find('.bomb-state').text.downcase).to eq('destroyed')
end
