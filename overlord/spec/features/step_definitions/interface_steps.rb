require "capybara/cucumber"

Capybara.current_driver = :webkit

Given(/^an interface$/) do
  puts "lasdfhlakjsdhflkjashdflkajshdfljashdflkjhasldkfjhasldkjhflaksjhdf"
  #within("#session") do
    visit("http://localhost:4567/")
  #end
end

Then(/^I have the ability to enter an activation code$/) do
  #within("#session") do
    fill_in('code', with: "foobar")
  #end
end

#Given(/^I have entered the correct activation code into a text field$/) do
#  #within("#session") do
#    visit("http://localhost:4567/")
#    fill_in('code', with: "1234")
#  #end
#end
#
#Given(/^the bomb's active state is false$/) do
#  #within("#session") do
#    expect(rendered).to have_content('BOMB INACTIVE')
#  #end
#end
#
#When(/^I submit the form$/) do
#  # browser.button(:name => 'submit').click
#  #within("#session") do
#    click_link("submit")
#  #end
#end
#
#Then(/^the bomb active state should become true$/) do
#  #within("#session") do
#    expect(rendered).to have_content('BOMB ACTIVE')
#  #end
#end
#
#Given(/^The bomb's active state is true$/) do
#  # browser.goto 'http://localhost:4567/'
#  # expect(browser.text.include?("BOMB ACTIVE")).to be true
#end
#
#Given(/^I enter the correct activation code into a text field$/) do
#  # browser.text_field(name: 'code').set 1234
#  # browser.button(:name => 'submit').click
#end
#
#Then(/^nothing should happen$/) do
#  # expect(browser.text.include?("BOMB ACTIVE")).to be true
#end
#
#Given(/^I have an active bomb$/) do
#  # browser.goto 'http://localhost:4567/'
#  # expect(browser.text.include?("BOMB ACTIVE")).to be true
#end
#
#Given(/^I enter the correct deactivation code$/) do
#  # browser.text_field(name: 'code').set "0000"
#  # browser.button(:name => 'submit').click
#end
#
#Then(/^the bomb state should become inactive$/) do
#  # expect(browser.text.include?("BOMB INACTIVE")).to be true
#  # browser.close
#end
#
#Given(/^I activate the bomb$/) do
#  # browser = Watir::Browser.new
#  # browser.goto 'http://localhost:4567/'
#  # browser.text_field(name: 'code').set 1234
#  # browser.button(:name => 'submit').click
#end
#
#Given(/^I enter the incorrect deactivation code (\d+) times$/) do |arg1|
#  #browser.goto 'http://localhost:4567/'
#  #browser.text_field(name: 'code').set "foo"
#  #browser.button(:name => 'submit').click
##
#  #browser.text_field(name: 'code').set "bar"
#  #browser.button(:name => 'submit').click
##
#  #browser.text_field(name: 'code').set "baz"
#  #browser.button(:name => 'submit').click
#end
#
#Then(/^the bomb should detonate$/) do
#  # expect(browser.text.include?("BOMB DETONATED")).to be true
#end
#
#Given(/^the bomb has been detonated$/) do
#  # browser.goto 'http://localhost:4567/'
#  # browser.text_field(name: 'code').set 1234
#  # browser.button(:name => 'submit').click
#end
#
#Then(/^the interface should no longer respond to user input$/) do
#  # expect(browser.text.include?("BOMB DETONATED")).to be true
#  # browser.close
#end
#
#Given(/^an inactive bomb$/) do
#  # browser = Watir::Browser.new
#  # browser.goto 'http://localhost:4567/'
#end
#
#Then(/^the interface should display BOMB DEACTIVATED$/) do
#  # expect(browser.text.include?("BOMB INACTIVE")).to be true
#end
#
#Given(/^an active bomb$/) do
#  # browser.goto 'http://localhost:4567/'
#  # browser.text_field(name: 'code').set 1234
#  # browser.button(:name => 'submit').click
#end
#
#Then(/^the interface should display BOMB ACTIVE$/) do
#  # expect(browser.text.include?("BOMB ACTIVE")).to be true
#end
