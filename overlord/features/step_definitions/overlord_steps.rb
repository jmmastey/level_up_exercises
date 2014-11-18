Given(/^I wait for ajax request to finish$/) do
  start_time = Time.now
  until page.evaluate_script('jQuery.active==0') or start_time < Time.now do
    sleep 1
  end
end


When(/^I wait for (\d+) seconds$/) do |seconds|
  sleep seconds.to_i
end
