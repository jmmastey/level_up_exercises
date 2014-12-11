

Given(/^a bomb is created$/) do
	visit('bomb/inactive')
	# TODO: create a new bomb or go off the last created one?
	# expect(session).to contain(:bomb)??????
end

When(/^I activate a bomb$/) do
	fill_in("activattion_code", with: '1234')
end