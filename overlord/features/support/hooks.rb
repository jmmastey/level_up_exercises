require 'timecop'

Before('@arm') do
  visit "/"
  fill_in "activation_code", with: "1234"
  click_on "submit"
end

After('@disarm') do
  fill_in "deactivation_code", with: "1234"
  click_on "submit"
end

After('@faketime') do
  Timecop.return
end
