Given(/^The bomb has not been initialized$/) do
  @bomb = nil
end

Given(/^The bomb has been activated$/) do
  visit('/')
  page.find('#activate').click
  fill_in('actcode', :with=>'1234')
  page.find('#activate').click 
end

Given(/^I have a bomb that was activated and then deactivated$/) do
	step 'The bomb has been activated'
	#code to deactivate bomb
end