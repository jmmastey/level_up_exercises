Given(/^the bomb is not yet booted$/) do
end

Given(/^the bomb is booted with codes "(.*?)" and "(.*?)"$/) do |activation_code, deactivation_code|
  visit("/")
  boot_bomb(activation_code, deactivation_code)
  click_button("Boot")
end

def boot_bomb(activation_code, deactivation_code)
  fill_in("Activation Code", with: activation_code)
  fill_in("Deactivation Code", with: deactivation_code)
end
